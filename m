From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: Re: nand booting - sdp 2430
Date: Wed, 20 Dec 2006 12:02:27 -0600
Message-ID: <782515bb0612201002j14995297s5e7c3e42f8b4d77b@mail.gmail.com>
References: <8bf247760612200639h2bb7045etfc78bdc1a3e51bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <8bf247760612200639h2bb7045etfc78bdc1a3e51bb3@mail.gmail.com>
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
To: Ram <vshrirama@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Ram,
On 12/20/06, Ram <vshrirama@gmail.com> wrote:
> Hi,
>  Sir, im trying to boot kernel from Nand using xloader.
>
>  Im using CCST tool to burn the xloader. Im using Omap 2430 SDP Board.
>
> Xloader download, compiled and Signed by IFT Setup tool.
Signed using IFT - Isnt' that obsolete? I think you should be using
CSST to sign it.. check the CSST documentation on guidance how to.
also pls pop in the CSST version you are using..
>
>
> I followed the following steps to do that
> 1)  I downloaded the xloader and burnt it to the nand at  0x0C000000.
>
> 2) I downloaded and burnt the u-boot (OS Loader) at (0x0010000 + 0xC00000)
>
>    I got this address from the include/configs/omap2430sdp.h
>
> /* NAND is partitioned:
>  * 0x0000000 - 0x0010000        Booting Image
>  * 0x0010000 - 0x0050000        U-Boot Image
>  * 0x0050000 - 0x0080000        U-Boot Env Data (X-loader doesn't care)
>  * 0x0080000 - 0x00B0000        Kernel Image
>  * 0x00B0000 - 0x4000000        depends on application
>  */
>
> 3) I changed the Dip Switch setting S8-3 (CS0_0) to OFF so that
What abt sysboot? just the CS_SEL is no good without letting OMAP know
that CS0 is NAND?
> Onboard Nand is CS0.
Err... are u downloading to NAND/ONENAND? you mentioned nand
previously and 0x0C is 16 bit nand rt?
>
>
> When i restart the board, It just hangs. Im not sure if im doing
> something wrong?.
Though U'd be able to get it from Documentation, here are my notes
(not sure of thier accuracy now... but then..):
NAND Boot:
S10 - Main Board						
1	2	3	4				
ON	ON	ON	ON				
user	user	user	user				
S9 - Main Board						
1	2	3	4	5	6	7	8
ON	ON	OFF	ON	ON	ON	ON	OFF
S8 - Main Board						
1	2	3	4	5	6	7	8
ON	ON	OFF	ON	ON	ON	ON	OFF
S6 - Main Board						
1	2	3	4	5	6	7	8
ON	ON	OFF	OFF	OFF	OFF	OFF	ON
S4 - Main Board						
1	2	3	4	5	6	7	8
OFF	OFF	OFF	OFF	ON	ON	OFF	OFF
SW1 - User Interface board					
1	2	3	4				
OFF	ON	ON	ON				
SW1 - T2 Power Board					
1	2	3	4				
ON	ON	ON	ON				

OneNAND boot:
S10 - Main Board						
1	2	3	4				
ON	ON	ON	ON				
S9 - Main Board						
1	2	3	4	5	6	7	8
OFF	ON	OFF	ON	ON	ON	ON	OFF
S8 - Main Board						
1	2	3	4	5	6	7	8
OFF	OFF	OFF	ON	ON	ON	ON	OFF
S6 - Main Board						
1	2	3	4	5	6	7	8
ON	ON	OFF	OFF	OFF	OFF	OFF	ON
S4 - Main Board						
1	2	3	4	5	6	7	8
OFF	OFF	OFF	OFF	ON	ON	OFF	OFF
SW1 - User Interface board					
1	2	3	4				
OFF	ON	ON	ON				
SW1 - T2 Power Board					
1	2	3	4				
ON	ON	ON	ON				

Hope this helps,
Regards,
Nishanth Menon
