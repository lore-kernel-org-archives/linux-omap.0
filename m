From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: OMAP1 IrDA driver doubts
Date: Wed, 14 Dec 2005 04:07:39 -0800 (PST)
Message-ID: <20051214120739.66516.qmail@web32910.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A50365E870@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50365E870@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "G Kondaiah, Manjunath" <xgkondai@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "G Kondaiah, Manjunath" <xgkondai@ti.com> wrote:

> Hi Komal,
> 
> A) is required since the same lines are shared between IrDA and aGPS
> modules. There is an I/O Expander to select these lines on H3/H4
> using
> I2C.

Thanx. I have taken it as set_power function for a while in the recent
patch posted on the list for 24xx irda support, but I will try to
rename it something different in the next patch.

Could you please comment on the B) and C) also? _or_ It would be gr8,
if you give me some patch review comments :)

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
