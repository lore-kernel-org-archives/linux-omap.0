From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Thu, 22 Mar 2007 10:06:08 +0900
Message-ID: <00c001c76c1e$4861dbe0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
	<1174506610.15255.101.camel@vence.hilman.org>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-reply-to: <1174506610.15255.101.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Kevin Hilman' <khilman@mvista.com>, "'Jalori, Mohit'" <mjalori@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> 
> > > RFC: Notice the change to onenand_base.c which comments 
> out the last
> > >      OOB chunk.  Without this, it would not work.  
> Previous drivers
> > >      for this board such as the 2.6.10-based MV kernel have this
> > >      same change.  Anyone know what is going on here?
> > > 
> > 
> > We got this change from MV in the patch he sent to fix an 
> issue we were
> > seeing with mounting an empty jffs2 partition. Here are the comments
> > that came in with it
> > 
> > " The oobfree list in the MTD OneNAND driver is of length 8.  This
> > exceeds the maximum length of 7, because the eighth entry 
> must be used
> > as a null terminator.  The absence of a terminator causes a 
> variety of
> > problems in various places (especially JFFS2 and YAFFS2) where the
> > oobfree list is scanned.  The fix is to do without the 
> eighth entry. 

Colud you point out the source code line where used the eightn entry used as a
null terminator?

In linux-2.6.15-omap they also allocate 8 oobfree. 

struct nand_oobinfo {
        uint32_t useecc;
        uint32_t eccbytes;
        uint32_t oobfree[8][2];
        uint32_t eccpos[32];
};

> > 
> > This fix is only of local interest because the handling of 
> oobinfo has
> > been completely redesigned as of 2.6.17-rc6. "
> 
> This problem still exists in the current OMAP tree 
> (2.6.21-rc4), so the
> MTD driver still needs some work.

It's some strange. I'm always working with omap tree with OneNAND support.
Of course it's working well with latest omap tree. The apollon board can boot
and use the jffs2 on OneNAND.

There are two cases using OOB. 
1. OOB_AUTO
2. OOB_PLACE
The recent change in JFFS2 which uses the OOB_AUTO.

In case 1, it's only used the first oobfree in JFFS2. So they don't use the
last oobfree
In case 2, it uses the full oobfree. but actually it used 12 bytes in jffs2. it
means it used 5 oobfree

> 
> I will work to get a fix for this submitted upstream.  In the 
> mean-time,
> my patch is required for OneNAND to work in the current git tree.

Could you send the debug message or error mesage when it is used without
oobfree patch?

Thank you,
Kyungmin Park
