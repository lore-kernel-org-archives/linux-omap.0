From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: Trasnferring u-boot to P2 730
Date: Fri, 07 Apr 2006 09:47:18 -0700
Message-ID: <44369796.9030300@mvista.com>
References: <3d3153f60604070015g5e260b69v3bc680d29f99fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3d3153f60604070015g5e260b69v3bc680d29f99fc@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ola Helm <ola.hel@gmail.com>
Cc: cp_singh@faith.co.jp, Linux-omap-open-source@linux.omap.com, kangjw@lenovo.com
List-Id: linux-omap@vger.kernel.org

Ola Helm wrote:
...
>> I have also tried to have connection via JTAG but it does not get
>> connected
>> even though I tried different switch / jumper settings, now
>> JP1: 1-2
>> JP2: 1-2
>> JP3: 2-3

I did this once via an Abatron BDI-2000.  George Davis had previously 
got it working using the small JTAG debug board that shipped with some 
versions of OMAP 730/16xx based on the "surfer" board; so far as I know 
we never got a BDI to talk to the multiport debug card shipped with P2 
boards.  On the JTAG board:

     * Jumper JP1 at 2-3
     * Jumper JP2 at 1-2
     * Jumper JP3 at 1-2

The P2 switches that worked for me included NOR and FULL/FASTBOOT = ON.

bdi config file used:

WM32	0xfffecc0c	0x00000012	; EMIFS CONFIG = NOR flash CS3

and maybe some other stuff that I cribbed from the u-boot board setup code.


-- 
Todd
