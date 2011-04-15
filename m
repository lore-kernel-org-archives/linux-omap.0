From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH 1/2] MTD: s3c2410_nand: Add option to disable hw ECC at
 runtime
Date: Fri, 15 Apr 2011 17:01:11 +0300
Message-ID: <1302876071.3220.60.camel@localhost>
References: <1302637672-25339-1-git-send-email-lars@metafoo.de>
	 <1302782911.2796.21.camel@localhost>  <4DA7094D.9070002@metafoo.de>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DA7094D.9070002@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Holger Freyther <zecke@openmoko.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-04-14 at 16:48 +0200, Lars-Peter Clausen wrote:
> On 04/14/2011 02:08 PM, Artem Bityutskiy wrote:
> > On Tue, 2011-04-12 at 21:47 +0200, Lars-Peter Clausen wrote:
> >> From: Holger Freyther <zecke@openmoko.org>
> >>
> >> This patch adds a flag to the s3c2410_nand platform data, which co=
nfigures
> >> whether hardware ECC is used.
> >>
> >> Currently it is only possible to decide whether hw ECC should be u=
sed or not at
> >> compile time through a config option. But if you want to build a k=
ernel which
> >> runs on multiple devices you might have a configuration where some=
 devices
> >> require hw ECC and some devices which want software ECC.
> >>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >=20
> > Extending platform data is kind of vetoed in arm tree, I do not thi=
nk
> > the MTD tree can take these changes.
> >=20
> That is not my understanding of the situation. But what do you sugges=
t as an
> alternative for fixing this issue?

Well, I got this understanding by talking to the OMAP maintainer and by
chatting with rmk. But I might be wrong. So the understanding is that
board data extending is banned, at least for a while. And the arm world
has to consolidate and probably switch to the DT tree approach. This
would be painful, this would make some vendors to return to behind the
curtains, so this would be a step back in the short run.

But in a couple of years this would be resolved, may be under Linaro's
aegis, and then the arm world would make 2 steps forward, so that
previous step back would be compensated in the longer run.

But! I'm just an small MTD guy, so I might be mistaken. Of course if yo=
u
make your board file changes be merged via the corresponding arm
sub-tree - go ahead send your MTD driver updates! This is I guess the
answer to your "what do you suggest" question.

CCing the arm lists so that people could correct me.

Here is the beginning of the thread:
http://lists.infradead.org/pipermail/linux-mtd/2011-April/034866.html

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)
