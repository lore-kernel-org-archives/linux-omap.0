From: Simon Knopp <simon.knopp@pg.canterbury.ac.nz>
Subject: YUV422 input to CPI?
Date: Fri, 20 Apr 2012 09:56:06 +1200
Message-ID: <E47FC7FC-B1CC-4E8A-9957-AEAF483DDAFA@pg.canterbury.ac.nz>
Reply-To: "General mailing list for gumstix users."
	<gumstix-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <gumstix-users-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/gumstix-users>,
	<mailto:gumstix-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=gumstix-users>
List-Post: <mailto:gumstix-users@lists.sourceforge.net>
List-Help: <mailto:gumstix-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/gumstix-users>,
	<mailto:gumstix-users-request@lists.sourceforge.net?subject=subscribe>
Errors-To: gumstix-users-bounces@lists.sourceforge.net
To: linux-omap@vger.kernel.org, "General mailing list for gumstix users." <gumstix-users@lists.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

Hi all,

I have a camera module capable of outputting YUV422 over a parallel interface. I've been having some issues interfacing this to a Gumstix. Reading through the OMAP3530 tech ref, I'm now beginning to wonder whether it is actually possible to input YUV422 to the CPI? 

-  Section 12.1.1 mentions RGB and YeCyMgG for "image sensors"; YUV is only mentioned for CS1&2. 
-  On the other hand, 12.4.6.1 says that the CCDC accepts YUV data in numerous formats.

Is anyone able to confirm whether it's possible to input YUV422 to the CPI?

Thanks,
Simon
------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
