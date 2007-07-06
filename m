From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: 2430 FB driver issues
Date: Fri, 6 Jul 2007 17:22:51 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470142EA63@dlee13.ent.ti.com>
References: <468E9632.1080205@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <468E9632.1080205@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>, nishanth menon <menon.nishanth@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

>nishanth menon wrote:
>> Hi All,
>>
>> On compiling the kernel for 2430sdp with defconfig, I see the
>> following error messages on shell:
>> Power Management for OMAP2 initializing
>> PRCM revision 1.0
>> omapfb omapfb: irq error status 40e2
>> omapfb omapfb: irq error status 0040
>> omapfb omapfb: irq error status 4022
>> omapfb omapfb: irq error status 4000
>> <snip>
>> omapfb omapfb: irq error status 4000
>> <snip>
>> I believe this is from drivers/video/omap/dispc.c:876. I have tried
>> two versions of uboot: one with PRCM 5a and the other with PRCM2.
>> neither worked. The kernel version is the latest pull from omap-git
>> from source.mvista.com.
>>
>> On disabling framebuffer, it boots up fine.
>
>FWIW, I have the same errors, but have not debugged it further.
>

I am not seeing any such messages and it boots happily.=20
I am using u-boot 1.1.4 Apr 20 2007, PRCM 2, 2430 SDP V4.0.

According to Nishanth's dump, The status shows LCD sync lost, which =
happens when there is no data to sync up or when DSS is operating at low =
frequency (not able to feed continuous data to LCD). I verified register =
set with TI's DSS drivers, every thing looks reasonable. The PCD is also =
proper (8) the DSS FCLK is 41.25 Mhz. I don't see any issues. If I get =
some time I will try with other board.

Regards,
Khasim
