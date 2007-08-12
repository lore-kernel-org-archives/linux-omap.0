From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: 2430 GPIO programming example ?
Date: Sun, 12 Aug 2007 17:36:27 +0300
Message-ID: <57314e840708120736m56a034d8ke73c08ec2b4041ee@mail.gmail.com>
References: <57314e840708120608i38c3f786rb8839c4dc42d75f8@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C470184AB9D@dlee13.ent.ti.com>
	<57314e840708120717q4366efc8qafed742326966636@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901A1C73B@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742901A1C73B@dlee13.ent.ti.com>
Content-Disposition: inline
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

On 8/12/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> It would be more efficient for all if you did a little research.

ok sorry you have a point.

> Through out the code base there are several examples of usage.

thank you. but can you just please tell me shortly what is the effect
of these functions ? it will greatly help me to understand the examples i
find:

extern void omap_disable_gpio_wakeup(int gpio);
extern int  omap_enable_gpio_wakeup(int gpio,int idlemode);
extern void gpio_unmask_irq(unsigned int irq);

thank you
budhee
