From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCHv7] media: i2c/adp1653: fix includes
Date: Mon, 13 Apr 2015 10:32:16 +0200
Message-ID: <CABxcv==j=GLq0o6Shr32-81-6o0z4mSMOm7c_4Q1e+rQBgdEKQ@mail.gmail.com>
References: <20150404074337.GA31064@amd>
	<20150404102435.GR20756@valkosipuli.retiisi.org.uk>
	<20150404171116.GA15025@Nokia-N900>
	<20150404200307.GS20756@valkosipuli.retiisi.org.uk>
	<20150409074238.GA22603@amd>
	<20150409091017.GA4526@earth>
	<20150409112943.GA31173@amd>
	<20150409121913.GB18713@earth>
	<20150409123155.GB9563@amd>
	<CABxcv=mB=LqO2paGfYq1jCbky=kudT-mS8cJ-pPwdqZYQLeO4A@mail.gmail.com>
	<20150409125927.GC12339@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150409125927.GC12339@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, m.chehab@samsung.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, mchehab@osg.samsung.com, hverkuil@xs4all.nl
List-Id: linux-omap@vger.kernel.org

Hello Pali,

On Thu, Apr 9, 2015 at 2:59 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> On Thursday 09 April 2015 14:43:59 Javier Martinez Canillas wrote:
>>
>> Please re-spin your previous patch and submit it properly.
>>
>> Best regards,
>> Javier
>
> Hi all! What about stopping this meaningless discussion about resendi=
ng
> full patch series when everybody know how to fix is quickly in editor
> (e.g with sed under 5s) and not wasting another 10 minutes to generat=
e
> new unified diff sent via SMTP protocol?
>

No, there is a reason why we have written rules on how patches should
be submitted. Everyone in the kernel community is expected to optimize
their workflow according to these rules to make life easier for people
reviewing and merging the patches.

As you said now someone has to fix this using an editor and that is an
error prone process. Besides, why it would take 10 minutes to generate
a proper patch-set? git is very good on this regard (i.e: git commit
---fixup && git rebase -i && git format-patch && git send-email).

I won't argue anymore but I find very sad that people who have been in
the kernel community for years don't follow the basic rules we have
documented it. So I wonder why we have the documentation in the first
place and how can we expect newcomers to follow if even experienced
kernel hackers don't.

> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

Best regards,
Javier
