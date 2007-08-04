From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 11/22] omap2 clock: fix some clocks incorrectly marked
 aspresent on OMAP2430
Date: Sat, 4 Aug 2007 09:56:03 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0708040951470.2982@utopia.booyaka.com>
References: <20070802181002.792550043@pwsan.com>
	<20070802181142.567475486@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF233@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708031204130.30569@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF8C3@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429018FF8C3@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Fri, 3 Aug 2007, Woodruff, Richard wrote:

> The current TRM for both 243x and 242x is version Q as of July 07.

That would explain it.  I will pick up the more recent revisions.  In the 
meantime, I will fix the patch to preserve sys_clkout2 for 2430, and also 
to fix the register bits to indicate that they are not 2420-only.

> So you need h, i, j, k, l, m, n, o, p, and q :).  The documentation just keeps getting better.

Does TI publish revision histories?  Might be easier than diff'ing 11 
3500-page PDFs :-)

>>> In 2420ES1 there was no clockout2 it was added for ES2 and beyond.
>>
>> hmm, wonder if we should add some clock flags for ES revisions...
>
> Well, the difference between ES1 and ES2 can be noticeable (especially 
> for 242x).  But no one has gone to production on an ES1 either.  There 
> shouldn't be so many to warrant a flag.  In the past we have tracked 
> this to keep the pain down in transition from ES1 to ES2 but as time 
> goes on most everyone gets updated.

Ok, thanks, sounds like we can do without it for the time being.


- Paul
