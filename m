From: "Liad Weinberger" <weliad@gmail.com>
Subject: Problems with remote debugging on OSK5912
Date: Mon, 26 Jun 2006 21:24:48 +0300
Message-ID: <3889f29f0606261124t6be72811y9564c9681f2b89fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi list,

I have built the entire toolchain on my own, using several guides I found on
the web. I also managed to compile a 2.6.16.20 kernel configured for the
board, and u-boot 1.1.1.2, both are running ok on the board. By ok I mean
that there does not seem to be any problems with them.

I am now trying to get GDB to work so that I could finalize my development
environment. To test GDB, I created a simple hello world program, and
cross-compiled it with '-g' as the only flag. I transfered the result binary
to the filesystem and tested to see that it runs ok. It did. I than
cross-compiled gdbserver and put it on the board, and also compiled gdb.
following are the steps I took to compile both:

For GDB:
   $ ../../gdb-6.4/configure --target=arm-linux --prefix=~/arm/tools
   $ make
   $ make install

For GDB-Server:
   $ CC=arm-linux-gcc ../../gdb-6.4/gdb/gdbserver/configure --host=arm-linux
--prefix=~/arm/rootfs/usr
   $ make
   $ make install

Now, on the tboard I ran:

   # gdbserver :6666 helloworld
   Process helloworld created; pid = 721
   Listening on port 6666

And on the host:

   $ arm-linux-gdb helloworld
   ...
   This GDB was configured as "--host=i686-pc-linux-gnu
--target=arm-linux"...
   (gdb) target remote 10.0.0.3:6666
   Remote debugging using 10.0.0.3:6666
   0x40000b80 in ?? ()
   (gdb)

Once I did that, on the board I got:

   Remote debugging from host 10.0.0.2

Now, here's the strange thing. It seems that the execution did not enter any
function yet:  "0x40000b80 in ?? ()" If I try to break at main I get:

   (gdb) break main
   Breakpoint 1 at 0x84dc: file helloworld.c, line 10.

Seems ok. Trying to continue gives the following:

   (gdb) cont
   Continuing.
   Program received signal SIGTRAP, Trace/breakpoint trap.
   0x4000be30 in ?? ()


trying to step gives me:

   (gdb) step
   Cannot find bounds of current function

calling main:

   (gdb) call main
   $1 = {int ()} 0x84cc <main>

and now continueing several times:

   (gdb) cont
   Continuing.
   Program received signal SIGILL, Illegal instruction.
   0x4000be34 in ?? ()
   (gdb) cont
   Continuing.
   Program terminated with signal SIGILL, Illegal instruction.
   The program no longer exists.


Now, the server exits on the board.

Well, as you can guess, I have no clue as to where the problem can be. I
tried googling for an answer and found nothing. If you can point me in a
direction I would very much appreciate it.


Thanks in advance,

         Liad Weinberger.
