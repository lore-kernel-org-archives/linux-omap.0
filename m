From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Abt git trees and ti sources (was Re: Pending April patches)
Date: Wed, 02 May 2007 06:30:42 -0500
Message-ID: <46387662.3000109@gmail.com>
References: <46374339.4030102@googlemail.com>	<20070502084714.4a23397d.jarkko.nikula@nokia.com>	<57314e840705012317m45e2d42y3120f2247393d8f7@mail.gmail.com>	<5d5443650705020134n55148159i4d30a35b12695a66@mail.gmail.com>	<57314e840705020149v194e4807j886a7efaa15f324@mail.gmail.com>	<5d5443650705020246v3e4427b9t9290d3e18de4ff4b@mail.gmail.com>
	<57314e840705020407q4823911i508d7ad24da47302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <57314e840705020407q4823911i508d7ad24da47302@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Budhee,
Budhee Jamaich stated on 5/2/2007 6:07 AM:
> Let me see I understand this.
> TI has published two kernel tarballs - 2.6.10 and 2.6.14 which fully
> supports the OMAP.
Depends on which omap you are speaking of... in short - yes. TI gives
its own variant of the kernel to the community.
> But - the community is working on this git source tree, which is
> up-to-date
> with current kernel, and slowly port code from TI's code into the git
> tree ?
Not necessarily. Tricky part in a development to a new h/w is the exact
registers and sequence of operation. It is really great to get a
reference code in this respect. But, some stuff we'd need to do it
ourselves. Think of TI code more as a reference code. what you see there
need not be the same as to what u'd see in the git. Dont ask me which
one is better (supported and code wise too)... each has its own + and -.
>
> and another question - is there an OMAP-based product, of a big brand,
> that uses (or used) this git tree as a basis of their kernel ?
Aaaah... Now, can git kernel be a successful base for a production code?
Here is one big reality of a production quality code (kernel/application
or anything): stability. Any code can only be stable if we refuse to add
features and go through a long stage of testing... but  as you'd know
the git always moves forward... where would u draw a line and stop other
people's development on the tree for ur product? This is part of the
dilema most companies could face using opensource git as a product
model. The risk ofcourse is obsolote kernel variant.... in comparison to
the latest kernel ofcourse.

Now, the right question you can ask in this list is: will the git tree
boot up in any OMAP-based branded product? the answer would be a yes -
atleast I have seen nokia: N800(2420 I think), N770(1710 i think)
patches on this list... Now if your question is: are there OMAP-based
branded products using "git based" code(not necessarily back in our git
tree)... I suspect there could be many out there in the wild...

I am sure there are folks on this list more capable than I to explain
this more...
Regards,
Nishanth Menon
