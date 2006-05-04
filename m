From: Eduardo Gallofin <egallofin@yahoo.com>
Subject: init (busybox) problem on OSK5912
Date: Thu, 4 May 2006 00:59:41 -0700 (PDT)
Message-ID: <20060504075941.50253.qmail@web52309.mail.yahoo.com>
References: <OFD42F04BA.70938876-ON65257164.00280E9D-65257164.0028488C@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <OFD42F04BA.70938876-ON65257164.00280E9D-65257164.0028488C@flextronicssoftware.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Chetan,

   You can do a "make menuconfig" on the busybox
source directory to use the GUI-like configuration
tool. Select <build options> and select <Build busybox
as a static library>. Save the configuration and
compile.

  To check if your busybox program is linked
statically, you can do a "file busybox" on your linux
machine and see the file attributes. It should show
"statically linked".

  The /lib and /usr/local/lib folders are already part
of the basefs, and having busybox as statically linked
doesn't affect these folders. Although when you
compile your programs statically, you won't be needing
the library files.

   Hope this helps. I really would like to compile all
my apps dynamically since this would save a great deal
of disk space, especially when you have multiple apps
sharing the same libraries. Statically compiled
programs are huge!!! 

- Ed



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
