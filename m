From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: OMAP1 IrDA driver doubts
Date: Wed, 14 Dec 2005 06:24:50 -0800 (PST)
Message-ID: <20051214142450.97282.qmail@web32911.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A50365E8B6@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50365E8B6@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "G Kondaiah, Manjunath" <xgkondai@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "G Kondaiah, Manjunath" <xgkondai@ti.com> wrote:

> 
> For H3 - Only bit 31 is valid for enabling UART clock. Setting bit 15
> has no effect.  You can remove this and use clock api's.  I am not
> sure
> about H2. 
> 
> drivers/net/irda/omap-ir.c -
> 
> it is better if UART defines are moved to arch specific header file
> 
> include/asm-arm/arch-omap/irda.h  - copyright header is missing.

Thanx for the review. I agree with your comments. I will make necessary
changes in the next release of patch.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
