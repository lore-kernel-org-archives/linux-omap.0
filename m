From: Vineet Tuli <vineet@cybernetra.com>
Subject: Re: where to find cross-compiled versions of gdbserver?
Date: Fri, 30 Dec 2005 09:31:56 +0530
Message-ID: <1135915316.2528.3.camel@vineet.linux>
References: <200512292001.jBTK1FeQ010806@sabine.ext.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200512292001.jBTK1FeQ010806@sabine.ext.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Dear M Letti,

One of my friend, Meenakshi prepared the following howto for cross
compiling GDB for ARM. I am enclosing the same.

Thanks

Vineet

***********************************************************************************************
Howto build gdb for ARM

NOTE: The following compilation was done on Fedora Core 4 Linux.

Download the gdb pakage from the following site:

ftp://ftp.gnu.org/gnu/gdb	wget -c ftp://ftp.gnu.org/gnu/gdb/gdb-6.3.tar.bz2

Place the downloaded file in /usr/src directory of your system.

Under /usr/src, create a debug directory and extract the gdb package in this (/usr/src/debug) directory. 

[root@localhost]# cd /usr/src/debug
[root@localhost]# tar jxf ../gdb-6.3.tar.bz2

Build gdb debugger

The debugger must be built into directories separate from the source. Thus, create a directory for gdb within the /usr/src/debug directory.

[root@localhost]# mkdir /usr/src/debug/build_gdb

NOTE: The following file of source code of gdb-6.3 needs to be patched for successful compilation of gdb:

	/usr/src/debug/gdb-6.3/sim/arm/iwmmxt.c 

Chose the prefix for the new debugger. This is a directory where the binary and other debugger files resides. This application report uses /opt/gdebug for the new debugger. The directory is created by the installation of the tools. Go to the /usr/src/debug/gdb-6.3 directory to configure and then build the binary and other debugger files with the commands shown below.

[root@localhost]# cd /usr/src/debug/build_gdb
[root@localhost]# ../gdb-6.3/configure --target=arm-linux --prefix=/opt/gdebug
[root@localhost]# make
[root@localhost]# make install

The binary generated resides in /opt/gdebug and is fairly large. This is why the gdb binary can't be used as-is on the target and the gdbserver is used instead.

Build gdb server

The gdb server wasn't built earlier because it has to be cross-compiled for the target using the appropriate tools. To do so, create a directory to build the gdb server, move to it and build the gdb server:

[root@localhost]# mkdir /usr/src/debug/build_gdbserver
[root@localhost]# cd /usr/src/debug/build_gdbserver
[root@localhost]# export PATH=/opt/arm/3.4.1/bin:$PATH
[root@localhost]# CC=arm-linux-gcc ../gdb-6.3/gdb/gdbserver/configure --host=arm-linux --prefix=/opt/gdebug/arm-linux
[root@localhost]# make
[root@localhost]# make install

The gdb server binary, 'gdbserver', has now been installed in your /opt/gdebug/arm-linux/bin directory.

Once built, copy gdbserver to the target's root file system.

On Thu, 2005-12-29 at 21:00 +0100, M Letti wrote:
> Dear Sirs,
> 
>  
> 
> I use the precompiled toolchain (version 3.3.2) on my OSK5912, which is
> available from http://linux.omap.com/pub/toolchain/ .
> 
> So far so good, I can use the arm-linux-gcc command to compile my own
> programs for my target.
> 
>  
> 
> But now that I want to debug these apps remotely, I'm looking for the
> cross-compiled versions of gdb and gdbserver (that is, arm-linux-gdb and
> arm-linux-gdbserver.and wonder, if they shouldn't be included in the
> toolchain I downloaded already? I just can't find them.(they are not in the
> 3.3.2/bin directory where for example the arm-linux-gcc resides)
> 
>  
> 
> Could anyone please point me out where they normally would be located, or if
> I have to cross-compile them on my own (in fact, I have already tried this
> step, but got mass of errors when executing "make").
> 
>  
> 
> 
> 
> By the way, I would like to ask you if you by chance can recommend any
> graphical development and debugging tools for my target (besides DDD & co)?
> Are there for example any special Eclipse plugins I could use, or should I
> use normal Eclipse environment and just set the remote debugging
> configuration appropriately to develop for my target?
> 
>  
> 
> 
> 
> Thank you very much in advance,
> 
>  
> 
> Michael
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
