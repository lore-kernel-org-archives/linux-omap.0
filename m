From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 3/3] ARM: OMAP: Add menelaus chip info for N800
Date: Wed, 06 Jun 2007 15:47:14 -0400
Message-ID: <46670F42.40800@indt.org.br>
References: <5d5443650705260129v3f118e25pc4ded86b1ccb57f3@mail.gmail.com>	
	<5d5443650706050429w4dd1f9a3i88bea4880c988b2f@mail.gmail.com>	
	<46657635.7060902@indt.org.br>
	<5d5443650706060034o7ded97a7red9b02ca549a9d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5d5443650706060034o7ded97a7red9b02ca549a9d28@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Trilok Soni wrote:
> On 6/5/07, Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:
>> ext Trilok Soni wrote:
>> > Let me know if anybody tested this patch on N800. Thanx.
>> >
>> > ---Trilok Soni
>> >
>> > On 5/26/07, Trilok Soni <soni.trilok@gmail.com> wrote:
>> >> n800 changes are compile tested only. Please test.
>> >>
>> >> --
>> >> --Trilok Soni
>> >>
>> >>
>> > _______________________________________________
>> > Linux-omap-open-source mailing list
>> > Linux-omap-open-source@linux.omap.com
>> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>> >
>> Hi Tony and Trilok,
>>
>> I've tested the patches
>> 0001-ARM-OMAP-Use-new-style-I2C-driver-for-Menelaus-chip.patch
>> (http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010100.html)
>>
>> and 0003-ARM-OMAP-Add-menelaus-chip-info-for-N800.patch
>> (http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010102.html)
>>
>>
>> by applying it together over MMC multislot support patches series for
>> N800 and looks fine (both slots with MMC, SD and SDHC cards).
>>
>> To test it, I'm using linux-omap tree, on commit
>> 9a0fba3f2ca8e58a1465d6c3c18f9f334d054304). Today I'll test with most
>> updated tree.
>>
>
> Thanx for the testing. Please share the result once you test it with
> latest tree.
>
Hi folks,

Well, testing with most update linux-omap tree, I'm having some warnings
compilations (with or without patches series applied):

WARNING: arch/arm/mach-omap2/built-in.o(.data+0x674): Section mismatch:
reference to .init.text:omap2_clk_disable_unused (between
'omap2_clk_functions' and 'onchip_clks')
WARNING: arch/arm/vfp/built-in.o(.data+0x0): Section mismatch: reference
to .init.text:vfp_testing_entry (between 'vfp_vector' and
'vfp_notifier_block')
WARNING: arch/arm/plat-omap/built-in.o(.data+0x95c): Section mismatch:
reference to .init.text:omap_timer_init (between 'omap_timer' and
'omap_32k_timer_irq'

and when starting the device I get the following message:

...
Starting MAEMO AF Desktop
matchbox-wm: can't open display! check your DISPLAY variable.
DSME: process '/usr/bin/matchbox-window-manager -theme default
-use_titlebar yes -use_desktop_mode plain -use_lowlight no -use_cursor
yes -use_dialog_mode s1DSME: process '/usr/bin/matchbox-window-manager
-theme default -use_titlebar yes -use_desktop_mode plain -use_lowlight
no -use_cursor yes -use_dialog_mode sd and restarted with pid 1646
Segmentation fault
...

And then not starting the graphical environment. :(

Anyway, by enabling debugging messages, the MMC looks fine.

Regards,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
