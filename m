From: "Budhee Jamaich" <budheej@gmail.com>
Subject: Re: OMAP2430: networking errors
Date: Fri, 18 May 2007 10:05:40 +0300
Message-ID: <57314e840705180005k713ed0dcn5f3ce8b932c4f131@mail.gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47F15BFE@dlee13.ent.ti.com>
	<464CC8E7.9090308@css-design.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <464CC8E7.9090308@css-design.us>
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
To: Steve Poulsen <spoulsen@css-design.us>, "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >> It'd be interesting to understand why the OMAP has trouble working
> >> with those low cost switches (or the opposite), while standard PCs
> >> seem to work fine with the...   but I guess I won't have the time
> >> to explore it too much... :(

> Syed Mohammed, Khasim wrote:
> > As I know, the SMC91 driver for OMAP configures the chip in half duplex. Generally PCs will be configured to work Full duplex. Don't know if this is the problem, but giving you some start for reasoning :)

Hmm. interesting. although, AFAIK, duplex mismatch can cause PHY collisions,
which result in slow down of the PHY channel. it cannot result in anomalies
such as I had (one side sees a packet, the other side ignoring it).
unless I have misfigured something about it ?

On 5/18/07, Steve Poulsen <spoulsen@css-design.us> wrote:
>  - The board is getting powered off and on multiple times.
>  - Each power-on often sets up the SMC91 through u-boot, uses it, then
> it disappears and gets connected again via the kernel (which may have a
> different setup).
>  - The developer often has multiple boards with the same MAC address, or
> some boards that have a MAC address that has changed for some reason.
>  - Switches maintain the ARP table and I imagine cheap switches don't
> expect the above strange occurrences.

True, all of this definately cause problems. But, in my case, I've tried even
to reset the cheap switch after I finished the u-boot session, and just before
I bootm'ed my kernel. now the differences between the two switches were
overwhelming - so this must be something deterministic and consistent.

Thanks all for the ideas !!
Budhee
