From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: omap2430 kernel bootlog
Date: Wed, 17 May 2006 05:38:29 -0700 (PDT)
Message-ID: <20060517123829.12222.qmail@web37911.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A505B25349@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A505B25349@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "Woodruff, Richard" <r-woodruff2@ti.com> wrote:

> I wouldn't run at 330MHz initially unless you are using a 2430-ES2
> and
> have capable memory.
> 

The flashed u-boot shows PRCM#3. But I haven't concentrated much on the
u-boot source right now and PRCM tables from TRM. As I just wanted to
have some minimal kernel booting with omap-git tree and to submit the
patch to mailing list, so people having 2430 can play with it and
possibly know the base address changes. This EVM shows 

"OMAP2430C-GP revision 0, PRCM #3
TI 2430SDP Base Board + 0.1 Version + mDDR"

> One bit from left field is I locally move the interrupt controllers
> physical mapping as the current address causes a conflict with the
> peripheral remap register which results in poor TLB usage (ARM core
> downsizes automatically).  I might submit a patch to git for this, or
> it
> may also filter out in one of our updates.

Thanx. I will wait for it.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
