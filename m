From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/15] OMAP: DSS2: DSI driver
Date: Wed, 5 Aug 2009 18:04:47 +0300
Message-ID: <20090805150446.GS7374@atomide.com>
References: <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-6-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-7-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-8-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-9-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-10-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55918 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075AbZHEPE4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 11:04:56 -0400
Content-Disposition: inline
In-Reply-To: <1249481741-14008-11-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  drivers/video/omap2/dss/dsi.c | 3509 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 3509 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/dsi.c
> 
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c

<snip snip>

> +int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen)
> +{
> +	u32 val;
> +	u8 dt;
> +	int r;
> +
> +	if (dsi.debug_read)
> +		DSSDBG("dsi_vc_dcs_read(ch%d, dcs_cmd %u)\n", channel, dcs_cmd);
> +
> +	r = dsi_vc_send_short(channel, DSI_DT_DCS_READ, dcs_cmd, 0);
> +	if (r)
> +		return r;
> +
> +	r = dsi_vc_send_bta_sync(channel);
> +	if (r)
> +		return r;
> +
> +	/* RX_FIFO_NOT_EMPTY */
> +	if (REG_GET(DSI_VC_CTRL(channel), 20, 20) == 0) {
> +		DSSERR("RX fifo empty when trying to read.\n");
> +		return -EIO;
> +	}
> +
> +	val = dsi_read_reg(DSI_VC_SHORT_PACKET_HEADER(channel));
> +	if (dsi.debug_read)
> +		DSSDBG("\theader: %08x\n", val);
> +	dt = FLD_GET(val, 5, 0);
> +	if (dt == DSI_DT_RX_ACK_WITH_ERR) {
> +		u16 err = FLD_GET(val, 23, 8);
> +		dsi_show_rx_ack_with_err(err);
> +		return -1;

Return something from err.h instead of -1 in various places in this function?

> +
> +	} else if (dt == DSI_DT_RX_SHORT_READ_1) {
> +		u8 data = FLD_GET(val, 15, 8);
> +		if (dsi.debug_read)
> +			DSSDBG("\tDCS short response, 1 byte: %02x\n", data);
> +
> +		if (buflen < 1)
> +			return -1;
> +
> +		buf[0] = data;
> +
> +		return 1;
> +	} else if (dt == DSI_DT_RX_SHORT_READ_2) {
> +		u16 data = FLD_GET(val, 23, 8);
> +		if (dsi.debug_read)
> +			DSSDBG("\tDCS short response, 2 byte: %04x\n", data);
> +
> +		if (buflen < 2)
> +			return -1;
> +
> +		buf[0] = data & 0xff;
> +		buf[1] = (data >> 8) & 0xff;
> +
> +		return 2;
> +	} else if (dt == DSI_DT_RX_DCS_LONG_READ) {
> +		int w;
> +		int len = FLD_GET(val, 23, 8);
> +		if (dsi.debug_read)
> +			DSSDBG("\tDCS long response, len %d\n", len);
> +
> +		if (len > buflen)
> +			return -1;
> +
> +		/* two byte checksum ends the packet, not included in len */
> +		for (w = 0; w < len + 2;) {
> +			int b;
> +			val = dsi_read_reg(DSI_VC_SHORT_PACKET_HEADER(channel));
> +			if (dsi.debug_read)
> +				DSSDBG("\t\t%02x %02x %02x %02x\n",
> +						(val >> 0) & 0xff,
> +						(val >> 8) & 0xff,
> +						(val >> 16) & 0xff,
> +						(val >> 24) & 0xff);
> +
> +			for (b = 0; b < 4; ++b) {
> +				if (w < len)
> +					buf[w] = (val >> (b * 8)) & 0xff;
> +				/* we discard the 2 byte checksum */
> +				++w;
> +			}
> +		}
> +
> +		return len;
> +
> +	} else {
> +		DSSERR("\tunknown datatype 0x%02x\n", dt);
> +		return -1;
> +	}
> +}
