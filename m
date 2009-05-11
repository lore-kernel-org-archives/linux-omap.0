From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: twl4030-madc conversions always time out
Date: Mon, 11 May 2009 14:14:49 +1200
Message-ID: <5a7b8b7b0905101914g7bef0069n812421454fac3419@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:43863 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbZEKCOt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 May 2009 22:14:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1518871ywb.1
        for <linux-omap@vger.kernel.org>; Sun, 10 May 2009 19:14:49 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>

Hi madc users,

I'm trying to use the twl4030-madc driver on my Overo-based OMAP3 board.

I'm using l-o 2.6.29 (git rev
58cf2f1425abfd3a449f9fe985e48be2d2555022) built using the OE 2.6.29
recipe.

I've made the changes to board-overo.c as per this thread:
http://www.nabble.com/ADC-timeout-on-Overo-td21222714.html#a21222714

and am using userspace test code like this:
	int d = open("/dev/twl4030-madc", O_RDWR | O_NONBLOCK);
	if (d == -1)
	{
		printf("could not open device\n");
		return 1;
	}
	
	struct twl4030_madc_user_parms *par;
	par = malloc(sizeof(struct twl4030_madc_user_parms));
	
	for (int i = 2; i < 8; i++)
	{
		printf("channel = %d ", i);
		memset(par, 0, sizeof(struct twl4030_madc_user_parms));
		par->channel = i;
		int ret = ioctl(d, TWL4030_MADC_IOCX_ADC_RAW_READ, par);
		if (ret == 0 && par->status != -1)
			printf("result = 0x%04x\n\n", par->result);
		else
		{
			if (par->status == -1)
				printf("timeout! ");
			printf("ERROR\n");
		}

		sleep(1); // avoid timing problems, just in case
	}

It consistently hits this timeout in the madc driver (i.e. -EAGAIN is
returned) even if I increase the timeout to, say, 1000 ms:

static int twl4030_madc_wait_conversion_ready(
		struct twl4030_madc_data *madc,
		unsigned int timeout_ms, u8 status_reg)
{
	unsigned long timeout;

	timeout = jiffies + msecs_to_jiffies(timeout_ms);
	do {
		u8 reg;

		reg = twl4030_madc_read(madc, status_reg);
		if (!(reg & TWL4030_MADC_BUSY) && (reg & TWL4030_MADC_EOC_SW))
			return 0;
	} while (!time_after(jiffies, timeout));

	return -EAGAIN;
}

It seems that the TWL4030_MADC_BUSY bit gets set and never cleared (as
in the aforementioned nabble thread).

Any ideas?

Cheers,
Hugo Vincent.
