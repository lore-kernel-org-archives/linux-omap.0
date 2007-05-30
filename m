From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH/RFC] Reduce OMAP2420 active current by ~30%
Date: Tue, 29 May 2007 20:08:36 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0705292005550.19832@utopia.booyaka.com>
References: <3B6D69C3A9EBCA4BA5DA60D91302742901158C39@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901158C39@dlee13.ent.ti.com>
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

On Tue, 29 May 2007, Woodruff, Richard wrote:

> This follows up on my power management tip yesterday to make sure to 
> enable module auto idles.  I was curious the savings on a 2420.  The 
> formatting needs some fix up (access & sharing for 2430) but it should 
> easily show the point.  This will apply against a git-pull from today.

Hi Richard,

took a quick look at the patch - is there any reason why this stuff can't 
use the new PRCM register and bit definitions?  That way you could drop 
stuff like this:

+#define CM_FCLKEN1_CORE                __REG32(0x48008200)
+#define CM_FCLKEN2_CORE                __REG32(0x48008204)
+#define CM_FCLKEN_WKUP         __REG32(0x48008400)
+#define CM_ICLKEN1_CORE                __REG32(0x48008210)
+#define CM_ICLKEN2_CORE                __REG32(0x48008214)
+#define CM_ICLKEN4_CORE                __REG32(0x4800821c)
+#define CM_ICLKEN_WKUP         __REG32(0x48008410)

and make code like this a little more self-documenting:

+       CM_FCLKEN1_CORE = 0xbfffffff;
+       CM_FCLKEN2_CORE = 0x00000006;
+       CM_FCLKEN_WKUP = 0x5;
+       CM_ICLKEN1_CORE = 0xcffffff9;
+       CM_ICLKEN2_CORE = 0x00000006;


- Paul
