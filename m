From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [PATCH] DSPBRIDGE: CLK_Enable and CLK_Disable Code cleanup
Date: Fri, 17 Apr 2009 17:46:33 +0300
Message-ID: <49E89649.9050103@yandex.ru>
References: <1239797948-30199-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:33117 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760738AbZDQOqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 10:46:49 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3HEkTlP027801
	for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 17:46:43 +0300
In-Reply-To: <1239797948-30199-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org

Ameya Palande wrote:
> -	       GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: CLK %s, "
> -			"CLK dev id=3D %d is already disabled\n",
> -			SERVICES_Clks[clk_id].clk_name,
> -			SERVICES_Clks[clk_id].id);
> +		pr_err("CLK_Disable: CLK %s, CLK dev id=3D %d is already
> +				disabled\n",
> +				SERVICES_Clks[clk_id].clk_name,
> +				SERVICES_Clks[clk_id].id);

NACK.

pr_err("A"
       "B");

not

pr_err("A
        B");

please.

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
