From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: [PATCH] omap24xx IrDA update
Date: Wed, 21 Dec 2005 05:49:10 -0800 (PST)
Message-ID: <20051221134910.6377.qmail@web32902.mail.mud.yahoo.com>
References: <EA12F909C0431D458B9D18A176BEE4A503838845@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A503838845@dlee02.ent.ti.com>
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
> The I/O expander on H4 uses I2C calls for changing the speed of the
> IrDA
> transceiver. Speed change request some times occurs in interrupt
> context, 

Thanx. Yes, I knew the reason of the crash as I had removed workqueue
interface and GPIO expander is using the I2C calls. Main goal was to
keep board specific data out of the driver, I am still looking at the
way to avoid board specific data in the driver and integrate work
queues in the best way.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
