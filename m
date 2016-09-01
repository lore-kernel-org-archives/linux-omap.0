From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Applied "mfd: tps65218: add version check to the PMIC probe" to
 the regulator tree
Date: Thu, 1 Sep 2016 09:18:34 +0100
Message-ID: <20160901081834.GE4921@dell>
References: <1466412218-5906-8-git-send-email-j-keerthy@ti.com>
 <E1bXZjd-0000YR-7n@debutante>
 <20160831083114.GP10121@dell>
 <20160831175701.GA5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160831175701.GA5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

On Wed, 31 Aug 2016, Russell King - ARM Linux wrote:

> On Wed, Aug 31, 2016 at 09:31:14AM +0100, Lee Jones wrote:
> > On Wed, 10 Aug 2016, Mark Brown wrote:
> > 
> > > The patch
> > > 
> > >    mfd: tps65218: add version check to the PMIC probe
> > 
> > Why did you take this patch?
> 
> I think folk need to start to understand the purpose of the To: and Cc:
> lines in emails.
> 
> To: means you're sending the message _to_ the recipient, expecting them
> to be the _primary_ receiver of the message, and to _process_ the message
> in some way.  In the case of a patch, that may be applying the change.
> 
> Cc: means you're providing the recipient with a copy of the message, "for
> their information" and you're not expecting them to take action.
> 
> If you think that there's no difference between To: and Cc: then ask
> yourself this question: what's the point of having the two headers,
> why not list all recipients under one single header.
> 
> Mark was in the To: line, therefore it is perfectly reasonable for him
> to apply the patch when it gets acked, since the original author sent
> it _TO_ Mark implicitly asking him to apply it.
> 
> If you have a problem with that, then you need to say something in
> reply to the patch, or you need to instruct folk who send patches for
> bits of your subsystem not to place others in the To: field who may
> pick up the patch.

It's not up to submitters which repo patches get applied to.  They are
free to make a verbal (written) request and if it's justified then we
can choose to agree to it or not.  For instance, a submitter is more
likely to know if a dependency was recently taken in via a particular
tree than a Maintainer, since it's almost impossible to keep track
each and every patch and all it's possible dependants.

I personally review/accept patches based solely on the subsystem(s)
touched and the actions of particular Maintainers, knowing firstly how
they operate.  Actioning patches based on whether a contributor uses
the To: or Cc: lines seems very fragile and prone to unnecessary
complications.

> However, there is a tendency with some people's mailers (including
> yours) which keeps the recipients of the To: and Cc: from the message
> being replied to, and copies them to the reply as-is.  That totally
> screws up the meaning of the To: and Cc: headers, and is really
> really really really annoying for people who are in the To: field
> but who aren't being asked to do anything in the replies.  (Fix your
> bloody mailer not to do this please!)

I use the Mutt's default configuration for 'reply-to-all' in all
cases.  I really don't have time to manually reorganise something as
trivial as To: and Cc: lines.  I find them irrelevant in this
setting.  Any time spent on trivial activities such as these adds
further delay to patch-reviews.  Some of us have day jobs too you
know. ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
