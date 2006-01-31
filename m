From: Paul Mundt <paul.mundt@nokia.com>
Subject: Re: gpio-switch problem
Date: Tue, 31 Jan 2006 17:07:16 +0200
Message-ID: <20060131150716.GA7466@nokia.com>
References: <43DF6AA8.3070200@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43DF6AA8.3070200@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Cohen <david.cohen@indt.org.br>
Cc: "Linux-omap-open-source@linux.omap.com" <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 31, 2006 at 09:48:24AM -0400, David Cohen wrote:
> I am trying to use the gpio-switch driver, but I am getting a problem
> when a new gpio switch is been registered. On new_switch function
> (gpio-switch.c file), the platform_device_register is returning a error.
> Has anyone already used, sucessfully, the gpio-switch driver?
> 
Yes.
