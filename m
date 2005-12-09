From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: OMAP touchscreen
Date: Fri, 9 Dec 2005 04:40:58 -0800 (PST)
Message-ID: <20051209124058.38181.qmail@web32908.mail.mud.yahoo.com>
References: <op.s1im95jptqqdru@tsunami.it.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <op.s1im95jptqqdru@tsunami.it.tut.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Mihail Georgiev <georgiev@students.cc.tut.fi>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Mihail Georgiev <georgiev@students.cc.tut.fi> wrote:

> Hello,
> 
>   I want to ask you about touchscreen events in OMAP system within
> gcc..
> 
>   I am using omap innovator 1510..and i need to catch touch on
> screen..
>   Because I am newbie in linux, please provide me some help:
>   I need to know - what kind of drivers must to be in linux (and how
> to
>   understand whether i have them)
>   How to install these drivers..
>   What kind of gcc libraries i need for that..
>   and...how to catch this event (whether there are already available
> source
>   examples for that..)
> 
> I have already tried the sample code in OMAP innovator software CD-
> touchscreen.c - but it not received events from touch screen...
> Did somebody tried to start this sample ?

Please try the kernel from 
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log;t=7

and visit 

http://www.muru.com/linux/omap README_GIT on how to fetch this kernel. 

For driver you can look at 

drivers/input/touchscreen/omap directory.

In user space you can use tslib (available from cvs repo on
arm.linux.org.uk website) utilities to test touchscreen. 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
