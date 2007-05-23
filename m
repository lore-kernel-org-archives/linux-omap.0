From: David Brownell <david-b@pacbell.net>
Subject: Re: [WIP] [PATCH] ARM: OMAP: Use new style I2C driver for Menelaus
	chip.
Date: Tue, 22 May 2007 23:53:29 -0700
Message-ID: <200705222353.29400.david-b@pacbell.net>
References: <5d5443650705110220j3d091db2t79047c29c5ee2b54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650705110220j3d091db2t79047c29c5ee2b54@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Friday 11 May 2007, Trilok Soni wrote:
> Tony/David,
> 
> I have attached the wip version of converting menelaus chip to use new
> style I2C driver bindings. I have tested it on H4 and it is working.

There's also an rtc-rs5c372 instance on H4 too, but menelaus seems
like the best place to start.

- Dave
