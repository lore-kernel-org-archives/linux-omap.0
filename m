From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Tue, 08 May 2012 22:25:55 +0200
Message-ID: <4FA98153.4050405@linaro.org>
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org> <1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55943 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966Ab2EHUZz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 16:25:55 -0400
Received: by eeit10 with SMTP id t10so488162eei.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 13:25:54 -0700 (PDT)
In-Reply-To: <1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/04/2012 07:18 PM, Daniel Lezcano wrote:
> Define a CPU_IDLE section in the makefile, declare the functions in
> the header files conforming to the kernel coding rules and remove the
> 'define's in the C files.
>
> CONFIG_PM is enabled when CPU_IDLE is enabled because the cpuidle dri=
vers
> use some functions from the pm subsystem.
>
> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet<j-pihet@ti.com>
> ---

Hi Kevin,

you did not apply this patch. Is it something wrong with it ?

Thanks
-- Daniel



--=20
  <http://www.linaro.org/>  Linaro.org =E2=94=82 Open source software f=
or ARM SoCs

=46ollow Linaro:<http://www.facebook.com/pages/Linaro>  Facebook |
<http://twitter.com/#!/linaroorg>  Twitter |
<http://www.linaro.org/linaro-blog/>  Blog


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
