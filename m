From: toshihiro.kobayashi@nokia.com
Subject: Re: Speex encoder running on DSP through DSP Gateway
Date: Sat, 14 Jan 2006 01:00:53 +0900 (JST)
Message-ID: <20060114.010053.846937934.toshihiro.kobayashi@nokia.com>
References: <a0580c510601110718v4d6f1a74r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <a0580c510601110718v4d6f1a74r@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: edubezval@gmail.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

From: Eduardo Bezerra <edubezval@gmail.com>
Subject: Speex encoder running on DSP through DSP Gateway
Date: Wed, 11 Jan 2006 11:18:39 -0400

>   I know that the issue below is related more to the DSP-GW community as
> opposed to Linux-OMAP and I do apologise for posting it here, but DSP-GW
> list seems to be populated sparringly and responses are really slow or
> long term.

However, eventually I'm answering in any ways. :)
I've been on the business trip followed by the vacation.
Sorry for slow replies.

>   I'm trying to run a speex encoder on the OSK 5912 DSP using
> DSP Gateway.  This enconder is based on the speex library
> that can be found in www.speex.org.
> 
>   The whole code to produce a single encoder using this library
> plus the tokliBIOS library code resulted in a binary with
> 200KB of size. A simple frame coding step also requires
> a stack size of 4K words. It also does about 12K words
> of allocation (using malloc). These memory requirements
> were analysed using valgrind tools.
> 
>   Because of these memory requirements, the DSP task needed some shared
> memory. So, I added one memory space to put some data. The .cmd
> of the DSP Task is:
> 
> /*
>  * Data sections
>  * */
> 
> -l tokliBIOScfg.cmd
> -l tokliBIOS.cmd
> 
> MEMORY {
>         PAGE 0: SARAM_D:     origin = 0x30000, len = 0x5000
> }
> SECTIONS {
>         shared_data:    {} > SARAM_D PAGE 0
> }
> 
>   However, as the application also needs more memory to
> stack and heap, I also modified the tokliBIOScfg.tcf:
> 
> .
> .
> .
> 
> var myHeap = bios.MEM.create("MYHEAP");
> myHeap.comment = "Speex Heap";
> myHeap.base = 0x1a800;
> myHeap.len = 0x8000;
> myHeap.createHeap = true;
> myHeap.space = "data";
> myHeap.heapSize = 0x4000;
> 
> bios.MEM.MALLOCSEG = prog.get("MYHEAP");
> bios.MEM.BIOSOBJSEG = prog.get("DARAM");
> bios.MEM.STACKSEG = prog.get("MYHEAP");
> bios.MEM.SYSSTACKSEG = prog.get("MYHEAP");
> 
> .
> .
> .
> /*
>  * TSK
>  */
> bios.TSK.ENABLETSK = true;
> bios.TSK.STACKSEG = prog.get("MYHEAP");
> 
>   I did a static compilation of this task and it was fine. Before the
> loading of the resulted binary, I executed the following commands on the
> OSK board:
> 
> # dspctl kmem_reserve 0x20000
> 
> As in the .cmd file, it needs a TLB entry pointing to 0x30000, size
> 0x5000
> # dspctl exmap 0x30000 0x5000
> 
> As in the .tcf file, it needs a TLB entry pointing to 0x35000, size
> 0x10000
> # dspctl exmap 0x35000 0x10000
> 
> 
>   So, I did the loading:
> 
> # dspctl start speex.out
> 
> 
>   The loading was fine also. But when I run a user space program to
> communicate to the DSP task through the DSP gateway device file, it
> gets an error. The user space program only sends a ipbuffer a requests
> another one. It sends and receives the ipbuffer without any problem.
> And the user space application ends. The data produced by the encoder is
> correct. The problem is that the kernel prints out a message indicating
> that there is a mailbox message from a non-existing DSP task. After
> that, the DSP task hangs out. The message error code is: BADTID.

Can you show me how you use bksnd() in your DSP task?
Because the TID used in the mailbox command is extracted from the "task"
argument passed with the bksnd().
Also the dump list of /sys/devices/platform/dsp/mblog may be some help.

BR,
Toshihiro Kobayashi
