From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Applied "mfd: tps65218: add version check to the PMIC probe" to
 the regulator tree
Date: Thu, 1 Sep 2016 15:23:19 +0100
Message-ID: <20160901142319.GC5783@n2100.arm.linux.org.uk>
References: <1466412218-5906-8-git-send-email-j-keerthy@ti.com>
 <E1bXZjd-0000YR-7n@debutante>
 <20160831083114.GP10121@dell>
 <20160831175701.GA5783@n2100.arm.linux.org.uk>
 <20160901081834.GE4921@dell>
 <20160901101743.GB5783@n2100.arm.linux.org.uk>
 <20160901111918.GJ4921@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160901111918.GJ4921@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, russ.dill@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 01, 2016 at 12:19:18PM +0100, Lee Jones wrote:
> On Thu, 01 Sep 2016, Russell King - ARM Linux wrote:
> 
> > On Thu, Sep 01, 2016 at 09:18:34AM +0100, Lee Jones wrote:
> > > On Wed, 31 Aug 2016, Russell King - ARM Linux wrote:
> > > 
> > > > On Wed, Aug 31, 2016 at 09:31:14AM +0100, Lee Jones wrote:
> > > > > On Wed, 10 Aug 2016, Mark Brown wrote:
> > > > > 
> > > > > > The patch
> > > > > > 
> > > > > >    mfd: tps65218: add version check to the PMIC probe
> > > > > 
> > > > > Why did you take this patch?
> > > > 
> > > > I think folk need to start to understand the purpose of the To: and Cc:
> > > > lines in emails.
> > > > 
> > > > To: means you're sending the message _to_ the recipient, expecting them
> > > > to be the _primary_ receiver of the message, and to _process_ the message
> > > > in some way.  In the case of a patch, that may be applying the change.
> > > > 
> > > > Cc: means you're providing the recipient with a copy of the message, "for
> > > > their information" and you're not expecting them to take action.
> > > > 
> > > > If you think that there's no difference between To: and Cc: then ask
> > > > yourself this question: what's the point of having the two headers,
> > > > why not list all recipients under one single header.
> > > > 
> > > > Mark was in the To: line, therefore it is perfectly reasonable for him
> > > > to apply the patch when it gets acked, since the original author sent
> > > > it _TO_ Mark implicitly asking him to apply it.
> > > > 
> > > > If you have a problem with that, then you need to say something in
> > > > reply to the patch, or you need to instruct folk who send patches for
> > > > bits of your subsystem not to place others in the To: field who may
> > > > pick up the patch.
> > > 
> > > It's not up to submitters which repo patches get applied to.  They are
> > > free to make a verbal (written) request and if it's justified then we
> > > can choose to agree to it or not.
> > 
> > Wrong.  It's up to submitters to send TO the person who they want to
> > apply the patch - that's how it's always worked.
> > 
> > What's become broken is this idea of "I absolutely own this area of the
> > kernel, all patches _must_ come through me."  That's never been the case.
> > 
> > There may be a good reason why the submitter doesn't want the normal
> > maintainer of an area of the kernel to take the patch, in which case
> > the submitter has every right to decide who should take their patch.
> > The wrong maintainer taking the patch can screw up the submitters
> > workflow, cause additional conflicts, or break dependencies.  The
> > submitter is the best person to decide who should apply their change.
> 
> I agree that the submitter is the best person to provide a compelling
> case to re-route a patch's normal submission path.  I disagree that
> they have the final say.

I'm *not* saying that they have the final say - that's completely _your_
invention.  They are making the request, and people can still ignore,
refuse, or reply saying that they don't want to take it - all of those
are valid actions of someone listed in the To: header.  However, you
should not be surprised if a person listed in the To: header does action
the merge if they think that's the reasonable thing for them to do.

> > If people want me to take some action with their message, they had
> > better put me in the To: line and _not_ the Cc, otherwise they're
> > risking me ignoring them for a long time.
> 
> I'm not sure many people work like that, sending or receiving.  In my
> case I deal with every mail I receive, firstly by brain grepping --
> skimming over the subject headers for mails I consider urgent.
> Everything else gets marked as 'important' and is dealt with
> chronologically.  No where in my workflow to do filter by, or consider
> To: and Cc: fields.  That just sounds like too much effort.

My mutt is normally set with "~p | ~P" so I don't even see any message
that I'm not expicitly listed in the To or Cc anymore - that's because
if I don't do that, due to the number of emails I get, I can't track
_anything_.  That was highlighted by a security bug that came up earlier
this year that got totally buried in my mailbox and completely forgotten.
Since then, I've decided that it's just impossible for me to do anything
but filter away every mail that I'm not explicitly in those headers.

I asked Linus how he deals with his mail, and he's the same: he may be
subscribed to several mailing lists, but he doesn't _read_ any email
that he's not listed in the To or Cc fields, and even then he tries to
get rid of it as quickly as possible.

So, I'm doing kind of what Linus does to cope with his mail stream: if
you want me to read your message, you have to put me in the headers,
otherwise be prepared for me to ignore your message for a very long
time (possibly never read it.)  And as I've said, wanting me to do
something needs me in the To: header because I'll look at those with
a higher priority.  Mutt makes that nice and easy, giving a T (for
To), C (for Cc), and a + for personal messages in the index.

But... my point still stands.  This is how To and Cc have worked
universally, even before email.  There's plenty of articles on the net
describing the correct use of To, Cc, and Bcc, most of which back up my
point.  It's a basic English writing skill and it was important when
sending memos around a company to get it right.  Thankfully, memos
didn't need to be threaded unlike emails today.  However, the same
point _does_ still exist.  It's down to pure laziness that this is not
followed as it should be, and it's not surprising that things go wrong
as a result.

So, keep making unreasonable expectations of others and writing poor
emails if you like, just don't expect the outcome you wish every time,
as illustrated by what happened earlier in this thread!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
