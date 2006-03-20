From: Matthew Percival <matthew@capgo.com>
Subject: Re: Linux DSP Tools or CCS-IDE?
Date: Tue, 21 Mar 2006 08:58:59 +1100
Message-ID: <1142891939.8946.2.camel@localhost.localdomain>
References: <7e6cc7550603192209w3a95d774u8713f76357d2e32d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7e6cc7550603192209w3a95d774u8713f76357d2e32d@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

>         Currently i am working with OMAP5912 starter kit. In the DSP
> application development, there are two options provided one with Linux DSP
> Tools and another with CCS-IDE with emulator. Is there any feature-wise
> difference between these two tools?. How many of you have preferred CCS-IDE
> instead of Linux DSP Tools? Which one is better for the application
> development?. Please help me in this regard.

	They are effectively the same thing: CCS is a front end for the same
tools that you get with the Linux DSP Tools.  It just comes down to what
kind of environment you are more familiar with.  Linux users are
traditionally more comfortable with IDE, so will tend to prefer CCS,
whilst GNU/Linux users are typically more comfortable with using the
shell, and as such will prefer to use the Linux DSP Tools in the way
they normally code.  If you have no preference either way, CCS would
probably be the easiest to learn with.

	-- Matthew
