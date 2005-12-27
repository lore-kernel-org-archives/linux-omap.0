From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: How to compress the filesystem
Date: Tue, 27 Dec 2005 04:10:55 -0800 (PST)
Message-ID: <20051227121056.68816.qmail@web32910.mail.mud.yahoo.com>
References: <7e6cc7550512270325m6cfef3cai88dfe007d3e60257@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <7e6cc7550512270325m6cfef3cai88dfe007d3e60257@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: naga rajan <nagubk82@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- naga rajan <nagubk82@gmail.com> wrote:

> Hi all,
> 
>          I followed the steps in* osk newbie guide & osk4 dummies
> *and
> generated my own filesystem. It comes around 28MB with specific
> library
> files required for my sample application. The factory filesystem
> image is
> around 14MB and it consists of all the library files in the /lib.I
> like to
> know how to compress my own filesystem to the factory filesystem
> level.Isthere any parameter has to be included with
> *mkfs.jffs2 *filesystem creation process?
> Please help me in this regard.

I don't know about the OSK supplied filesystem. But you may like to use
"arm-linux-strip" tool on the libraries.

---Komal Shah
http://komalshah.blogspot.com/


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
