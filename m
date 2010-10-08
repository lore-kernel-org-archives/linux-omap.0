From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: kgdb errors with serial console
Date: Fri, 08 Oct 2010 08:17:46 -0500
Message-ID: <4CAF19FA.7010206@windriver.com>
References: <BDD07355-7199-4A2E-8426-F6D43EA5D313@mac.com> <4CAE4BB6.7080509@windriver.com> <7BA01CAF-DD25-4AB6-9498-8AB89E2EDDE1@mac.com> <4CAE5B40.3070701@windriver.com> <917F9CCC-F3D3-4E23-B955-412F08CE8E2E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <917F9CCC-F3D3-4E23-B955-412F08CE8E2E@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10/08/2010 05:41 AM, Elvis Dowson wrote:
> Hi Jason,
>                       I'm getting eclipse target time outs, I've attached link to the video here : http://drop.io/kgdbwe01
>   

Because you are using a serial link you certainly want to close any
related to extra data you don't need.   Not knowing a whole lot about
what the Eclipse plugin gdb does, it is hard to know if this was an
eclipse timeout or not.

If you add the following to your .gdbinit it will at least tell you what
happened at the end.

set remotelogfile /tmp/gdb_serial_log.txt

It would be good to know if eclipse timed out and it just detached from
the target, or if some command crashed gdb.  It is purely a guess, but
it is probably eclipse requesting lots of information and simply timing out.



> and then launched eclipse debugger. It loads the vmlinux file, and a bunch of junk characters keep appearing continuously on the telnet session. 
>
>   

The "junk" you speak of is simply the gdb serial traffic, it is answered
in the FAQ


http://git.kernel.org/?p=utils/kernel/kgdb/agent-proxy.git;a=blob;f=README.TXT
> After about a minute or so, Eclipse terminates the session saying that it timed out. You can see this in the video. I edited the video, in between to trim off the long wait, with the characters scrolling in the terminal session, to the point where it crashes.
>
>   

I would not expect the terminal session to crash.  If an oops is
printed, it means there is an internal kgdb problem.

Jason.
