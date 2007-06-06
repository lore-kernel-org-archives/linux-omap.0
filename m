From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Add menelaus chip info for N800
Date: Wed, 6 Jun 2007 13:04:24 +0530
Message-ID: <5d5443650706060034o7ded97a7red9b02ca549a9d28@mail.gmail.com>
References: <5d5443650705260129v3f118e25pc4ded86b1ccb57f3@mail.gmail.com>
	<5d5443650706050429w4dd1f9a3i88bea4880c988b2f@mail.gmail.com>
	<46657635.7060902@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46657635.7060902@indt.org.br>
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
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 6/5/07, Carlos Aguiar <carlos.aguiar@indt.org.br> wrote:
> ext Trilok Soni wrote:
> > Let me know if anybody tested this patch on N800. Thanx.
> >
> > ---Trilok Soni
> >
> > On 5/26/07, Trilok Soni <soni.trilok@gmail.com> wrote:
> >> n800 changes are compile tested only. Please test.
> >>
> >> --
> >> --Trilok Soni
> >>
> >>
> > _______________________________________________
> > Linux-omap-open-source mailing list
> > Linux-omap-open-source@linux.omap.com
> > http://linux.omap.com/mailman/listinfo/linux-omap-open-source
> >
> Hi Tony and Trilok,
>
> I've tested the patches
> 0001-ARM-OMAP-Use-new-style-I2C-driver-for-Menelaus-chip.patch
> (http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010100.html)
> and 0003-ARM-OMAP-Add-menelaus-chip-info-for-N800.patch
> (http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010102.html)
>
> by applying it together over MMC multislot support patches series for
> N800 and looks fine (both slots with MMC, SD and SDHC cards).
>
> To test it, I'm using linux-omap tree, on commit
> 9a0fba3f2ca8e58a1465d6c3c18f9f334d054304). Today I'll test with most
> updated tree.
>

Thanx for the testing. Please share the result once you test it with
latest tree.

-- 
--Trilok Soni
