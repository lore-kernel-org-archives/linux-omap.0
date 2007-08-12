From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: 2430 GPIO programming example ?
Date: Sun, 12 Aug 2007 17:17:20 +0300
Message-ID: <57314e840708120717q4366efc8qafed742326966636@mail.gmail.com>
References: <57314e840708120608i38c3f786rb8839c4dc42d75f8@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C470184AB9D@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C470184AB9D@dlee13.ent.ti.com>
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 8/12/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
> Hope this helps.
you have no idea how much !
i mean i found the relevant gpio.h, but there were
no explanation on the function prototypes.. so thank you !!!

can u plz elaborate a bit what is debouce ?

and what are the following functions (and how do i work with them) ?

extern void omap_disable_gpio_wakeup(int gpio);
extern int  omap_enable_gpio_wakeup(int gpio,int idlemode);
extern void gpio_unmask_irq(unsigned int irq);

thank you again
budhee
