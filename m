From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: omap24xxcam status (Was: v4l2 camera test app)
Date: Mon, 20 Mar 2006 06:58:55 -0800 (PST)
Message-ID: <20060320145855.10464.qmail@web32908.mail.mud.yahoo.com>
References: <3d3153f60603200519t2173ce20l52d184b0a6a39ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3d3153f60603200519t2173ce20l52d184b0a6a39ff@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ola Helm <ola.hel@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Ola Helm <ola.hel@gmail.com> wrote:

> Hi,
> 
> Have you got some idea what's the situation of the 24xx camera driver
> at the
> moment? AFAIK the patch David sent in last month is not included to
> tree,
> propably since there were some opposite opinions about the way of
> implementation and at least I did not have one file mentioned in
> patch (I
> think you mentioned about the same issue)

24xx camera driver is now in David's hand. I just review the code now,
as not able to work on camera stuff anymore.
 
Following strategy can work out meanwhile as I had offline discussion
with David :)

o Separate 24xx CamDMA code from omap24xxcam.c to new file as 
  exported apis (Suggested by David)

o Keep the old omap24xxcam driver interface(2.6.8 TI kernel days), 
  having video out code part of the camera driver itself. As new 
  separated video out code depends upon the common display controller  
  library, which requires to change fb driver in git tree to adopt 
  that interface, so that video out, and fb driver can 
  utilize the same code. But video out patches submitted by me didn't 
  generated any discussion on the list in that direction. 

o So, to have 24xx camera code in git tree, we can use the old camera 
  driver interface as of now, if everyone agrees.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
