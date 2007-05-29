From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] USB: Fix OTG HNP for hub.c
Date: Tue, 29 May 2007 12:21:20 -0700
Message-ID: <200705291221.20343.david-b@pacbell.net>
References: <11804401622277-git-send-email-felipebalbi@users.sourceforge.net>
	<11804401752426-git-send-email-felipebalbi@users.sourceforge.net>
	<1180440176127-git-send-email-felipebalbi@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1180440176127-git-send-email-felipebalbi@users.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 May 2007, Felipe Balbi wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> This patch makes makes OTG Host Negotiation Protocol (HNP)
> to behave.

Not really.  It makes it strongly *MIS* behave in fact,
since it always kicks off HNP ... even when it should not
do so, because the device is in the whitelist.  (Called
the "Targeted Peripherals List", TPL, in jargonese.)

The two blocks of code are in the wrong order ...


A more limited patch would help.  Specifically, just
fixing whatever bug was seen in the original code,
rather than abstracting it into a new subroutine and
changing the logic while doing so.

- Dave


> +	/* If B-device wants to do HNP, it will do it after we suspend */
> +	if (bus->b_hnp_enable) {
> +		dev_err(&udev->dev, "trying HNP, suspending bus\n");
> +		err = __usb_port_suspend(udev, udev->bus->otg_port);
> +		if (err < 0) {
> +			dev_err(&udev->dev, "suspend for HNP failed\n");
> +			return -ENODEV;
> +		}
> +
> +		/* TB_ASE0_BRST, minimum 3.125 ms */
> +		mdelay(4);
> +
> +		/* Failed resume means B-device took over the bus with HNP */
> +		err = usb_port_resume(udev);
> +		if (err < 0) {
> +			dev_err(&udev->dev, "HNP success\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	/* HNP failed. Reject B-devices not in our whitelist */
> +	if (!is_targeted(udev))
> +		return -ENODEV;
> +
