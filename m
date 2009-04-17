From: Artem Bityutskiy <dedekind@yandex.ru>
Subject: Re: [PATCH][UPDATED] DSPBRIDGE: CLK_Enable and CLK_Disable Code cleanup
Date: Fri, 17 Apr 2009 18:38:52 +0300
Message-ID: <49E8A28C.1020104@yandex.ru>
References: <49E89649.9050103@yandex.ru> <1239981547-30944-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56815 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbZDQPi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 11:38:58 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3HFcT5e030623
	for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2009 10:38:58 -0500
In-Reply-To: <1239981547-30944-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org

Ameya Palande wrote:
>  	}
> -	return status;
> +	return ((int_clk_status | fun_clk_status) !=3D DSP_SOK) ? DSP_EFAIL=
 :
> +								DSP_SOK;
>  }

Side note:

Is it possible to rework the code and remove thse insane
DSP_EFAIL and DSP_SOK? Wouldn't it be possible to use
the good practices we have in kernel? Namely,

1. Return 0 on success.
2. Return negative error code on failure?=20

This is C, not visual basic, after all...

P.S. Ameya, do not take this as a personal attack. The
code is just so ugly and embarrassing, that I cannot stop
flaming :-)

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
