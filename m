From: Olav Kongas <ok@artecdesign.ee>
Subject: RE: Basic question: how to flash omap system with ccs?
Date: Tue, 29 Nov 2005 16:42:48 +0200 (EET)
Message-ID: <Pine.LNX.4.63.0511291629480.22513@pcy.artec.ee>
References: <438af835.547cd4ee.1b00.4646@mx.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <438af835.547cd4ee.1b00.4646@mx.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Li Weichen <iaadoa@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



On Mon, 28 Nov 2005, Li Weichen wrote:

> Hi Olav,
> 
> It is so kind of to reply.  I am very interested about your COFF generator.
> Would you please share it?  And could you give me some instructions showing
> the operating process if not so bother?

Here's the COFF header generator:

http://www.artecdesign.ee/~ok/coff_hdr.c.gz

About usage read the comments in the file. No special 
options for gcc needed.

By the way, I got also the flash programmer working.

Olav
