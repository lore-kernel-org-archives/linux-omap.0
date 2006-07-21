From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Playing mp3 on OMAP5912 OSK
Date: Fri, 21 Jul 2006 18:49:27 +0200
Message-ID: <44C10597.3060208@gmail.com>
References: <4477F81C.2000308@gmail.com> <447B06A5.6020500@indt.org.br>
	<447C76AB.8040901@gmail.com> <447C8682.8060201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <447C8682.8060201@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme wrote:
> Dirk Behme wrote:
> 
>> Anderson Briglia wrote:
>>
>>> I tested the ALSA driver presented in the latest git tree and madplay 
>>> is working properly.
>>
>>
>>>> output: ioctl(SNDCTL_DSP_SYNC): Invalid argument
>>
>>
>> Seems that this becomes strange. I used Anderson's madplay, libmad and 
>> .mp3 for tests. Anderson's mp3 is 44.1 kHz as well, so this shouldn't 
>> be the issue. My kernel sound configuration seems to be okay as well. 
>> But even with Anderson's binaries I get the ioctl error above. So last 
>> thing I can imagine is other kernel configuration.
> 
> 
> For the archive and fyi answering to myself:
> 
> Here's my 'what it is not' list:
> 
> - madplay binaries and libraries are okay
> - mp3 is okay
> - playing over NFS is okay
> - kernel config is okay
> 
> And now? Toolchain!
> 
> Compiling kernel with my old 3.4.1 gcc: madplay doesn't complain any 
> more. Compiling kernel with my newer 4.1.0 with same config and same 
> binaries: madplay fails. Haven't seen any other issues with my 4.1.0 
> yet, no error, failure, nothing.
> 
> Will see if I find time to investigate this further. Built my 4.1.0 with 
> crosstool-0.42 and crosstool's
> 
> eval `cat arm.dat gcc-4.1.0-glibc-2.3.2.dat`  sh all.sh --notest
> 
> configuration.

For the archive: Seems that this [1] is fixed with

http://gcc.gnu.org/viewcvs/branches/gcc-4_1-branch/gcc/cse.c?r1=115620&r2=115619&pathrev=115620

Many thanks to Paul Brook!

Regards

Dirk

[1] http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27363
