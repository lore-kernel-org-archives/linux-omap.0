From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: e-linux kernel for P2 board
Date: Mon, 12 Dec 2005 22:07:19 -0800 (PST)
Message-ID: <20051213060719.31730.qmail@web32909.mail.mud.yahoo.com>
References: <OFF4A7771E.9BBD83BD-ON652570D6.00190228-652570D6.0019F966@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <OFF4A7771E.9BBD83BD-ON652570D6.00190228-652570D6.0019F966@flextronicssoftware.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kiran Bynam <kiran.bynam@flextronicssoftware.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Kiran Bynam <kiran.bynam@flextronicssoftware.com> wrote:

> 
> 
> 
> 
> Hi All,
> 
> I am a  new user of the OMAP 730(P2 sample).
> 
> we want to port e-linux to the P2 board.
> 
> There are two versions of the e-linux available on the TI web site.
> 
>  2.4 kernel &  2.6. kernel
> 
> open source code is available for 2.6 kernel where as
> link is provided to Monta Vista site for 2.4 kernel.
> 
> Can anybody suggest me the difference between these two versions of
> e-linux?
> 


I hope you mean e-linux as embedded linux !. I would suggest you to use
2.6.x kernel, where all the latest development happens. Lot's of bugs
were fixed after 2.4.x.

You can fetch the latest git tree from 
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log;t=7

Instruction for OMAP-GIT:
http://www.muru.com/linux/omap

http://lwn.net/Articles/driver-porting/ _or_ LDD3 to see what is new
and make out differences yourself !

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
