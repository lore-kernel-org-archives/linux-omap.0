From: "Jacob Tanenbaum" <Jacob.Tanenbaum@logicpd.com>
Subject: [LogicPD] smsc911x_soft_reset: Failed to complete reset same problem as Zoom3
Date: Tue, 10 Aug 2010 13:52:09 -0500
Message-ID: <77A0A4DB5BF2A44283E5522C27234AC6021C7D0B@EDPRSRV011.logicpd.com>
References: <A24693684029E5489D1D202277BE894456EA309A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.logicpd.com ([66.162.60.3]:31963 "EHLO smtp.logicpd.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933002Ab0HJTIK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 15:08:10 -0400
Content-class: urn:content-classes:message
In-Reply-To: <A24693684029E5489D1D202277BE894456EA309A@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: saaguirre@ti.com


On linux-next commit ID 81e09f50c93edff607259cbe374a3006c9c5fa74

Has the same problem the LogicPD Torpedo has the same problem

[    2.411743] eth0: smsc911x_soft_reset: Failed to complete reset
[    2.417846] eth0: smsc911x_open: soft reset failed
[    2.422668] IP-Config: Failed to open eth0
[    2.426879] IP-Config: No network devices available.


-----Original Message-----
From: linux-omap-owner@vger.kernel.org
[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Aguirre, Sergio
Sent: Monday, August 09, 2010 4:36 PM
To: linux-omap@vger.kernel.org
Subject: [Zoom3] smsc911x_soft_reset: Failed to complete reset
(sometimes...)

Hi all,

Seems that, with current master branch
(commit ID: 842849896627701e4c07441f2c7519aeec771058),
and doing this change:

> diff --git a/drivers/net/smsc911x.h b/drivers/net/smsc911x.h
> index 016360c..2cd4f5a 100644
> --- a/drivers/net/smsc911x.h
> +++ b/drivers/net/smsc911x.h
> @@ -23,7 +23,7 @@
>  
>  #define TX_FIFO_LOW_THRESHOLD  ((u32)1600)
>  #define SMSC911X_EEPROM_SIZE   ((u32)7)
> -#define USE_DEBUG              0
> +#define USE_DEBUG              1
>  
>  /* This is the maximum number of packets to be received every
>   * NAPI poll */

I see in the console sometimes (not always) these error messages:

[    2.682342] eth0: smsc911x_soft_reset: Failed to complete reset
[    2.688385] eth0: smsc911x_open: soft reset failed
[    2.693176] IP-Config: Failed to open eth0
[    2.697326] IP-Config: No network devices available.

Is somebody also experiencing this?

NOTE: It doesn't seem consistent. I had to reboot several times the
board,
To reproduce it. Sometimes it comes at the first try.

Regards,
Sergio
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
