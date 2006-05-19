From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Framebuffer driver on OMAP 2430
Date: Fri, 19 May 2006 04:05:35 -0700 (PDT)
Message-ID: <20060519110535.14605.qmail@web37902.mail.mud.yahoo.com>
References: <904DEC693BE1AB429622C6F5ABA7E0B801066507@is01ex02.ittiam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <904DEC693BE1AB429622C6F5ABA7E0B801066507@is01ex02.ittiam.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Vaibhav Goyal <vaibhav.goyal@ittiam.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Vaibhav Goyal <vaibhav.goyal@ittiam.com> wrote:

> 
> Can anybody give me pointers as where to get framebuffer driver for
> OMAP 2430(DSP side)?

Contact your TI FAE for that, if they have some readymade example done
through c64x+ using TI DSPBridge. Let me clarify at this point:

* You can find linux-2.6.10 based Linux kernel on http://linux.omap.com
  for OMAP2430 done by TI.

* You can find minimal Linux OMAP-GIT tree port posted by me here:
Link:
http://linux.omap.com/pipermail/linux-omap-open-source/2006-May/007205.html

* There is _no_ open-source dspgateway available for c64x+/omap2430 as
of now. If you want you can start with
http://dspgateway.sourceforge.net and then write your fb omap2 dispc
interface there or something like FBEXPORT ioctl.


---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
