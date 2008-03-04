From: "jayant sonar" <jayants2704@gmail.com>
Subject: Problem in using CPP code on OMAP2430-DSP processor
Date: Tue, 4 Mar 2008 11:15:02 +0800
Message-ID: <ad8f31c80803031915g54551d70odd602c9d7c5eee38@mail.gmail.com>
References: <d8750c770803030803g4ed87f7v8f16e1179cfb1e7c@mail.gmail.com>
	<d8750c770803031900s14725d60s87facfba8fd0af2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <d8750c770803031900s14725d60s87facfba8fd0af2f@mail.gmail.com>
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

Hello,

I am a newbie to OMAP platform.
I am using OMAP2430 SDP with linux OS on board and using root
filesystem through NFS. I am compiling my
application from command line using GCC-4.1.1 toolchain.

I have a single huge CPP application which works fine on ARM.
Now I want to split the application in two threads, one to run on ARM
and other to run on DSP processor.

For the reference purpose, I have taken the "dmmcopy" sample
application provided by TI. I modified it to integrate my code into it.
My ARM code suppose to send a message to DSP processor to trigger
execution of DSP code. DSP code, on completion of its execution
should send another message back to the ARM, informing completion of
DSP execution.

I have included some part of my C++ code in a DSP source
file - dmmcopyExecute.c.
As by default this file gets compiled as a C file, it doesn't
recognizes any CPP members like class definitions etc and gives
compilation error. So I renamed dmmcopyExecute.c as a CPP
file - dmmcopyExecute.cpp. Then it got compiled successfully.
I modified the ddspbase.pjt for the same.

However, when i run my application on hardware, the execution is
failing at "DSPNode_Run" state itself.
This is much before my first message is send to DSP processor to trigger
its execution. I send my first message from "RunTask" function.
The return status value of the "DSPNode_Run" function is "0x8000801c".
I found that this return value indicates the unavailability of
"dmmcopyCreate", "dmmcopyDelete" or "dmmcopyExecute" symbols in DSP
base image.

What could be causing this problem?

To add few more CPP source file in DSP code, I've added them in
"Source" list in "proejct.pjt" file.
However, I am not sure whether this file is used when I am compiling
my source code from command line and not from CCS.
I don't have CCS tool.

Regards
Jayant
