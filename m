From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: Power domain addition.
Date: Wed, 21 Jun 2006 08:13:57 -0700 (PDT)
Message-ID: <20060621151357.21663.qmail@web37913.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A5064652ED@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5064652ED@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com, sampsa.fabritius@nokia.com
List-Id: linux-omap@vger.kernel.org

--- "Woodruff, Richard" <r-woodruff2@ti.com> wrote:

> Yes, see below for the reasons.  I guess the basic point is it still
> won't boot with out an Irda fix up.  I only highlighted the problem
> and
> supplied a rough hack.  Whoever looks after Irda should get it fixed,
> or
> have it removed from the default configuration. 
> It is possible its
> just
> a compiler bug which then make it a little less clear.  The bug is
> from
> a union structure of a u8 and u16 generating only byte aligned code
> which is a no-no when used with a lrdh.

I can submit the patch for removing IrDA from the defconfig, but before
that I will build the latest omap git tree, with code-sourcery 2005Q1B
release and will see that it stops at the same point or not.

> 
> This is because you can't just change MT_DEVICE to MT_MEMORY with out
> changing the mapping size.  Templates are not given for PTE
> generation
> only section entries.  That is why I changed the size to 1024*1024.
> As
> indicated I tried a quick extension to make my own type but found it
> must also change the code which sets the EXEC bit and didn't want to
> do
> that, so just increased the to something which would generate what I
> want.

I had just compiled and boot the latest pull from omap git tree, and
_not_ changed anything, so mapping size was 1024*1024 as per that
commited patch. But I think you had tested that setup with power
management enabled, which works in my case except IrDA.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
