From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 11/22] omap2 clock: fix some clocks incorrectly marked
 aspresent on OMAP2430
Date: Fri, 3 Aug 2007 12:09:02 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0708031204130.30569@utopia.booyaka.com>
References: <20070802181002.792550043@pwsan.com>
	<20070802181142.567475486@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429018FF233@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429018FF233@dlee13.ent.ti.com>
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

hi Richard,

On Thu, 2 Aug 2007, Woodruff, Richard wrote:

> CLOCKOUT2 is in the latest functional spec.  This might be a TRM error 
> or the removed the ball for later ES versions.

looking at 2430 ES2.1 TRM rev G, I can't find any mention of it - maybe 
this TRM is out-of-date?


> In 2420ES1 there was no clockout2 it was added for ES2 and beyond.

hmm, wonder if we should add some clock flags for ES revisions...


- Paul
