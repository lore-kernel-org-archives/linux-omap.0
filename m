From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: how to download x-load.bin into internal SRAM
Date: Wed, 3 Oct 2007 00:13:10 -0700
Message-ID: <a46a26fd0710030013q5d1eb724se878a7e941993e8f@mail.gmail.com>
References: <FBD03D6DFE9D7C4893187AAE6DD77F0C066DEC@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <FBD03D6DFE9D7C4893187AAE6DD77F0C066DEC@BLR-SGM-MSG01.wipro.com>
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
To: "aravind.boinpally@wipro.com" <aravind.boinpally@wipro.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

JTAG is able to load x-load into internal SRAM, at least on OMAP2430.

You need to sign the x-load.bin with CSST before flashing it to NAND. Read
the initialization-chapter from the TRM.
And the documentation is a bit ambiguous about valid SRAM destination
addresses, for me 0x40200000 did not work but 0x40404000 works.

 - Juha

On 10/2/07, aravind.boinpally@wipro.com <aravind.boinpally@wipro.com> wrote:
>
> Hi..alll
>
> i am facing problem with x-loader .i flashed x-loader into NAND
> flash,but it is not booting up.
>
> i wanted to download x-load.bin file into internal SRAM (0x4020 0000 ),
> to test my x-load.bin file is proper or not .?
>
> how can i download x-load.bin file into SRAM directly to
> execute..??(using CSSt or any other tool)??
>
> Thanking you.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>



-- 
Madness takes it's toll. Please have exact change.
