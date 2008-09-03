From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH 12/12] CORE OFF macro added, disabled by default
Date: Wed, 03 Sep 2008 16:25:51 +0300
Message-ID: <877i9txsww.fsf@trdhcp146196.ntc.nokia.com>
References: <63425.192.168.10.89.1220276570.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34002 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbYICNZh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 09:25:37 -0400
In-Reply-To: <63425.192.168.10.89.1220276570.squirrel@dbdmail.itg.ti.com> (ext
	Rajendra Nayak's message of "Mon, 1 Sep 2008 19:12:50 +0530 (IST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"ext Rajendra Nayak" <rnayak@ti.com> writes:
>
>  	  WARNING: Enabling this option may cause your device to hang!
>
> +config OMAP_CPUIDLE_CORE_OFF
> +	bool "CORE OFF support in CPUIdle"
> +	depends on ARCH_OMAP34XX
> +	default n
> +	help
> +	  Say Y if you want to enable CORE OFF support in CPUIdle
> +
> +	  Currently some drivers don't work well with OFF support
> +	  enabled in CPUIlde. Once all device drivers are adapted
> +	  to work with OFF mode in CPUIdle, this MACRO will be
> +	  removed.
> +

Would it make sense to use more generic macro here? Something that
could be shared between cpuidle, srf, pm_idle and suspend? It could
also affect to all powerdomains, not just core.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
