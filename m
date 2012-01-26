From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 12:19:52 +0100
Message-ID: <OFC79FBFFE.8722488C-ONC1257991.003E14E3-C1257991.003E3E9C@transmode.se>
References: <4F206213.9070704@flatfrog.com>
 <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com>
 <4F2127B8.9000005@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <4F2127B8.9000005@flatfrog.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Orjan Friberg <of@flatfrog.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

>
> On 01/25/2012 10:18 PM, Paul Walmsley wrote:
> > - If your oopses are consistently in the same places, add some debugging
> >    to that code to determine which line is actually causing the oops.
>
> (CC:d linux-mtd.)
>
> They are semi-consistent I'd say.  The oops trace I posted is by far the
> most common.
>
> >    problem to mysteriously disappear.  Doing this analysis should provide a
> >    good clue as to where to look next.  I personally would be rather
> >    suspicious of that
> >
> >       ri->data_crc = cpu_to_je32(crc32(0, comprbuf, cdatalen));
> >
> >    in jffs2_write_inode_range().
>
> That is indeed the place where crc32 is called from .  I'll see it I can
> track the use of comprbuf.
>
> > - Try turning on JFFS2 debugging and seeing if you can reproduce it.
> >    The output might provide a clue as to where the problem would be.
>

I would also turn off SUMMARY in JFFS2, I tried it long ago and it didn't make
much of a difference.

 Jocke


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
