From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Android on N810 File System Problem
Date: Sun, 27 Apr 2008 08:44:44 +0200
Message-ID: <481420DC.1050205@googlemail.com>
References: <6a56d69c0804241248w5e46efe8k757c9e5fb9e3ce22@mail.gmail.com>	 <48116F5C.9040009@googlemail.com>	 <6a56d69c0804251231u7fab3904w1939e8e8a3202a60@mail.gmail.com>	 <4812D62F.8090300@googlemail.com> <6a56d69c0804261921t197475b8w596ee93aa9be4f8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:19571 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbYD0GoN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Apr 2008 02:44:13 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3651364wxd.4
        for <linux-omap@vger.kernel.org>; Sat, 26 Apr 2008 23:44:12 -0700 (PDT)
In-Reply-To: <6a56d69c0804261921t197475b8w596ee93aa9be4f8d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Herriott <herriojr@gmail.com>
Cc: linux-omap@vger.kernel.org

Jonathan Herriott wrote:
> I had it confirmed in another thread

Any pointer to this thread?

Thanks

Dirk

>  that the issue is that the local
> filesystem for the N810 is jffs, which is unsupported and I need to
> install it on an mini SD card with ext2/ext3 on it.
> 
> On 4/26/08, Dirk Behme <dirk.behme@googlemail.com> wrote:
> 
>>Jonathan Herriott wrote:
>>
>>
>>>I'm using vanilla Kernel 2.6.21.0 with the patch from
>>>
>>
>>http://android-on-n8xx.googlecode.com/files/linux-2.6.21_rx-34_android-m5-rc14.bz2.
>>
>>> I was told in another thread that I need to use the m3 userspace
>>>files, but when trying to use those, I have the same issue.
>>>
>>>I'm assuming you want the strace when running init:
>>>
>>>\h:\w\$ strace -f -ff -tt -s 200 /init
>>>04:02:38.896362 execve("/init", ["/init"], [/* 59 vars */]) = 0
>>>04:02:38.909790 gettid()                = 1464
>>>04:02:38.912689 syscall_983045(0xbea0d614, 0, 0x20, 0, 0xbe9ee000,
>>>0xbea0d6d0, 0xbea0d720, 0xf0005, 0xbea0d720, 0, 0x80b8, 0x80b4, 0,
>>>0xbea0d608, 0x17c77, 0x17f2c, 0x60000010, 0xbea0d614, 0, 0, 0xc764, 0,
>>>0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
>>>04:02:38.916168 socket(PF_FILE, SOCK_STREAM, 0) = 3
>>>04:02:38.919250 connect(3, {sa_family=AF_FILE,
>>>path=@property_service}, 19) = -1 ECONNREFUSED (Connection refused)
>>>04:02:38.923248 close(3)                = 0
>>>04:02:38.926208 sigaction(SIGCHLD, {0x8211, [], SA_NOCLDSTOP}, NULL,
>>>0xc0fb8) = 0
>>>04:02:38.929718 umask(0)                = 022
>>>04:02:38.932373 ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost
>>>isig icanon echo ...}) = 0
>>>04:02:38.936523 dup(1)                  = 3
>>>04:02:38.939422 write(3, "init: HOW ARE YOU GENTLEMEN\n", 28init: HOW
>>>ARE YOU GENTLEMEN
>>>) = 28
>>>04:02:38.943328 close(0)                = 0
>>>04:02:38.945983 close(1)                = 0
>>>04:02:38.948577 close(2)                = 0
>>>04:02:38.951202 open("/dev/null", O_RDWR|O_LARGEFILE) = 0
>>>04:02:38.954345 dup2(0, 1)              = 1
>>>04:02:38.956939 dup2(0, 2)              = 2
>>>04:02:38.959625 write(3, "init: reading config file\n", 26init:
>>>reading config file
>>>) = 26
>>>04:02:38.963592 brk(0)                  = 0x20000
>>>04:02:38.966217 brk(0x20000)            = 0x20000
>>>04:02:38.968994 brk(0x21000)            = 0x21000
>>>04:02:38.971832 open("/etc/init.rc", O_RDONLY|O_LARGEFILE) = 4
>>>04:02:38.975006 lseek(4, 0, SEEK_END)   = 5746
>>>04:02:38.991088 lseek(4, 0, SEEK_SET)   = 0
>>>04:02:38.993286 brk(0x22000)            = 0x22000
>>>04:02:38.998413 read(4, "## Global environment setup\n##\nenv {\n
>>>PATH /sbin:/system/sbin:/system/bin\n    LD_LIBRARY_PATH
>>
>>/system/lib
>>
>>>\n    ANDROID_BOOTLOGO 1\n    ANDROID_ROOT /system\n
>>>ANDROID_ASSETS /system/app\n  ANDROID_"..., 5746) = 5746
>>>04:02:39.002288 close(4)                = 0
>>>04:02:39.003845 brk(0x23000)            = 0x23000
>>>04:02:39.005310 mkdir("/proc", 0755)    = -1 EEXIST (File exists)
>>>04:02:39.006622 mkdir("/dev", 0755)     = -1 EEXIST (File exists)
>>>04:02:39.007843 mkdir("/dev/pts", 0755) = -1 EEXIST (File exists)
>>>04:02:39.009368 mkdir("/sys", 0755)     = -1 EEXIST (File exists)
>>>04:02:39.011230 mkdir("/d", 0755)       = -1 EEXIST (File exists)
>>>04:02:39.012451 mount("/dev/pts", "/dev/pts", "devpts", 0, NULL) = -1
>>>EBUSY (Device or resource busy)
>>>04:02:39.017883 mount("/proc", "/proc", "proc", 0, NULL) = -1 EBUSY
>>>(Device or resource busy)
>>>04:02:39.026428 mount("/sys", "/sys", "sysfs", 0, NULL) = -1 EBUSY
>>>(Device or resource busy)
>>>04:02:39.033416 mount("/d", "/d", "debugfs", 0, NULL) = -1 EBUSY
>>>(Device or resource busy)
>>>04:02:39.038238 mount("/tmp", "/tmp", "tmpfs", 0, NULL) = 0
>>>04:02:39.043457 open("/proc/cmdline", O_RDONLY|O_LARGEFILE) = 4
>>>04:02:39.046417 read(4, "root=1f03 rootfstype=jffs2 ro\n", 1023) = 30
>>>04:02:39.048187 close(4)                = 0
>>>04:02:39.049346 chmod("/proc/cmdline", 0400) = 0
>>>04:02:39.050689 open("/system_properties", O_RDWR|O_CREAT|O_EXCL|
>>>O_LARGEFILE, 0600) = 4
>>>04:02:39.052368 ftruncate(4, 32768)     = 0
>>>04:02:39.053588 open("/system_properties", O_RDONLY|O_LARGEFILE) = 5
>>>04:02:39.056884 unlink("/system_properties") = 0
>>>04:02:39.058624 mmap2(NULL, 32768, PROT_READ|PROT_WRITE, MAP_SHARED,
>>>4, 0) = -1 EINVAL (Invalid argument)
>>>04:02:39.059997 close(5)                = 0
>>>04:02:39.061096 close(4)                = 0
>>>04:02:39.063110 open("/etc/default.prop", O_RDONLY|O_LARGEFILE) = 4
>>>04:02:39.064422 lseek(4, 0, SEEK_END)   = 130
>>>04:02:39.065521 lseek(4, 0, SEEK_SET)   = 0
>>>04:02:39.066619 read(4, "# default system properties\n# these may be
>>>overridden by /data/local.prop\n\nnet.bt.name = Android\n\n# end
>>>default system properties\n", 130) = 130
>>>04:02:39.069152 close(4)                = 0
>>>04:02:39.070251 --- SIGSEGV (Segmentation fault) @ 0 (0) ---
>>>04:02:39.072601 +++ killed by SIGSEGV +++
>>>Process 1464 detached
>>>
>>
>> Mmh, there are some reports on this list with similar SIGSEGV:
>>
>> http://marc.info/?l=linux-omap&m=120393103218574&w=2
>> http://marc.info/?l=linux-omap&m=120400327301855&w=2
>> http://marc.info/?l=linux-omap&m=120834030203728&w=2
>>
>> But It doesn't look like the archives have a detailed solution for this.
>>Seems that changing some parameters (e.g. switching to other binder driver,
>>SDK etc.) made the error go away.
>>
>> I'm CCing Anil and colorant, maybe they remember what helped.
>>
>> Dirk
>>
>>
>>
>>
>>>On Thu, Apr 24, 2008 at 10:42 PM, Dirk Behme <dirk.behme@googlemail.com>
>>
>>wrote:
>>
>>>
>>>>Jonathan,
>>>>
>>>>CCing OMAP mailing list, there are more people to help.
>>>>
>>>>
>>>>Jonathan Herriott wrote:
>>>>
>>>>
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>I'm trying to get android installed on an N810.  I have successfully
>>>>>installed the kernel,
>>>>>
>>>>>
>>>>
>>>>Which kernel (2.6.x, x == ?)  do you use on N810? If I remember
>>
>>correctly,
>>
>>>>with N810 people use an older kernel than the one coming with Android
>>
>>SDK.
>>
>>>>
>>>>
>>>>
>>>>
>>>>>but I am having major issues with the file
>>>>>system.  I followed the tutorial you provided at
>>>>>http://elinux.org/Android_on_OMAP, but I get a
>>
>>segmentation fault when
>>
>>>>>I try to init the kernel.  I made sure to use the same android SDK
>>>>>version that was used to patch the kernel.
>>>>>
>>>>>My steps for reproduction are:
>>>>>
>>>>>1) On my computer, unpack the ramdisk image to a folder.
>>>>>2) Untar system, dev, and data to the unpacked ramdisk image.
>>>>>3) Tar up the patched file system and scp it to /opt on the device.
>>>>>Ssh to the device and unpack the file system in /opt
>>>>>4) Run umask 000 && chroot /opt/android /init
>>>>>5) Receive a segmentation fault.
>>>>>
>>>>>
>>>>
>>>>Can you send us the complete segementation fault output?
>>>>
>>>>Regards
>>>>
>>>>Dirk
>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
> 

