From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 3/3] ARM: OMAP: Add menelaus chip info for N800
Date: Tue, 05 Jun 2007 10:41:57 -0400
Message-ID: <46657635.7060902@indt.org.br>
References: <5d5443650705260129v3f118e25pc4ded86b1ccb57f3@mail.gmail.com>
	<5d5443650706050429w4dd1f9a3i88bea4880c988b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650706050429w4dd1f9a3i88bea4880c988b2f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Trilok Soni <soni.trilok@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Trilok Soni wrote:
> Let me know if anybody tested this patch on N800. Thanx.
>
> ---Trilok Soni
>
> On 5/26/07, Trilok Soni <soni.trilok@gmail.com> wrote:
>> n800 changes are compile tested only. Please test.
>>
>> -- 
>> --Trilok Soni
>>
>>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
Hi Tony and Trilok,

I've tested the patches
0001-ARM-OMAP-Use-new-style-I2C-driver-for-Menelaus-chip.patch
(http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010100.html)
and 0003-ARM-OMAP-Add-menelaus-chip-info-for-N800.patch
(http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010102.html)

by applying it together over MMC multislot support patches series for
N800 and looks fine (both slots with MMC, SD and SDHC cards).

To test it, I'm using linux-omap tree, on commit
9a0fba3f2ca8e58a1465d6c3c18f9f334d054304). Today I'll test with most
updated tree.

Thanks in advance,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
