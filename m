From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: OMAP2430: networking errors
Date: Thu, 17 May 2007 16:28:07 -0500
Message-ID: <464CC8E7.9090308@css-design.us>
References: <9C23CDD79DA20A479D4615857B2E2C47F15BFE@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47F15BFE@dlee13.ent.ti.com>
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

Budhee,

Here are some differences that occur during development and many 
~should~ go away during release.

 - The board is getting powered off and on multiple times. 
 - Each power-on often sets up the SMC91 through u-boot, uses it, then 
it disappears and gets connected again via the kernel (which may have a 
different setup).
 - The developer often has multiple boards with the same MAC address, or 
some boards that have a MAC address that has changed for some reason.
 - Switches maintain the ARP table and I imagine cheap switches don't 
expect the above strange occurrences.

In a product, the booting is often flash-based and the network is 
brought up once by the kernel, with a unique non-changing MAC address.

Add this to Khasim's response below (which would indicate a problem 
all-around), and there's plenty of fun to be had by someone (not me) in 
figuring this out.

Good Luck!

Steve

Syed Mohammed, Khasim wrote:
>> It'd be interesting to understand why the OMAP has trouble working
>> with those low cost switches (or the opposite), while standard PCs
>> seem to work fine with the...   but I guess I won't have the time
>> to explore it too much... :(
>>
>>     
>
> As I know, the SMC91 driver for OMAP configures the chip in half duplex. Generally PCs will be configured to work Full duplex. Don't know if this is the problem, but giving you some start for reasoning :)
>
> Regards,
> Khasim
>
>   
