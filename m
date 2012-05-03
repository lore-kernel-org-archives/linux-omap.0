From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 11/18][V3] ARM: OMAP3: cpuidle - remove the 'valid' field
Date: Thu, 03 May 2012 22:29:00 +0200
Message-ID: <4FA2EA8C.90207@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org> <1335276339-11135-12-git-send-email-daniel.lezcano@linaro.org> <87r4v1kofi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43260 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2ECU3D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 16:29:03 -0400
Received: by eekc41 with SMTP id c41so650032eek.19
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 13:29:02 -0700 (PDT)
In-Reply-To: <87r4v1kofi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/03/2012 10:19 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> With the previous changes all the states are valid, except
>> the last state which can be handled by decreasing the number
>> of states.
> I don't think this changelog is valid anymore as you're not doing
> anything to decrease the number of states.
>
> I updated the changelog locally to this:
>
> ARM: OMAP3: cpuidle - remove the 'valid' field
>
> With the previous changes all the states are valid, except the last
> state which is now handled at runtime by next_valid_state() based on
> the errata flags.
>
> Any problems with that?

No problem :)

Thanks for fixing the Changelog.

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
