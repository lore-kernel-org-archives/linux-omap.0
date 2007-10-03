From: "arun c" <arun.edarath@gmail.com>
Subject: Re: how to download x-load.bin into internal SRAM
Date: Wed, 3 Oct 2007 15:22:06 +0530
Message-ID: <c656a4d20710030252v4bb5eabeu1234b84a4e04b5f7@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 10/3/07, aravind.boinpally@wipro.com <aravind.boinpally@wipro.com> wrote:
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
You can use ccs to download xload(elf) file into SRAM and you can debug it.
You need JTAG for it.

Regards,
Arun
