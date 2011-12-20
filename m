From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH V2 0/2] OMAPDSS: DISPC: Peformance improvement of DISPC Scaling
Date: Tue, 20 Dec 2011 17:46:51 +0530
Message-ID: <CAF0AtAu8bHRhKv0so49NiCbT2eyfAHn6+Rp74h+r2pK7wXqYqA@mail.gmail.com>
References: <1324283602-6383-1-git-send-email-cmahapatra@ti.com>
	<1324370169.2042.2.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:49555 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125Ab1LTMQw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 07:16:52 -0500
In-Reply-To: <1324370169.2042.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Dec 20, 2011 at 2:06 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Mon, 2011-12-19 at 14:03 +0530, Chandrabhanu Mahapatra wrote:
>> Hi everyone,
>> the following patch set directs to improve the scaling performance o=
f DISPC
>> module which consists of two pacthes.
>>
>> The first patch is based on code of Lajos Molnar <lajos@ti.com> from=
 Android
>> Kernel, which updates the code with new set of coefficients to impro=
ve the
>> scaling performance.
>>
>> The second patch is based on some very valuable suggestions by
>> Sebastien Fagard <s-fagard@ti.com> and directs to modify the clock
>> requirements for scaling to support OMAP4 and avoid clock failure is=
sues.
>>
>> I have tested these patches on OMAP2, OMAP3 AND OMAP4. To test on 24=
30SDP
>> board I have created a patch to enable the display which will follow=
 later.
>>
>> All your comments and suggestions are welcome.
>
> Thanks, this looks good. Applied to DSS master branch. There was a mi=
nor
> conflict with the Makefile, but I fixed that.
>
> Btw, when doing new versions of a patch series, it would be good to h=
ave
> a short history of the series in the introduction email, so that the
> reviewers can easily see what's new in each version.
>
> =A0Tomi
>
Thanks Tomi ! Its a good idea to including history of the series in
the introduction. I will do so in further patches to come.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
