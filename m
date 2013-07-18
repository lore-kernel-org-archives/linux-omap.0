From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC/PATCHv2 3/3] driver: spi: Add quad spi read support
Date: Thu, 18 Jul 2013 17:22:01 +0530
Message-ID: <51E7D6E1.3000208@ti.com>
References: <1374141687-10790-1-git-send-email-sourav.poddar@ti.com>
	<1374141687-10790-4-git-send-email-sourav.poddar@ti.com>
	<20130718104414.GH22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130718104414.GH22506-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: rnayak-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 18 July 2013 04:14 PM, Mark Brown wrote:
> On Thu, Jul 18, 2013 at 03:31:27PM +0530, Sourav Poddar wrote:
>> Since, qspi controller uses quad read.
>>
>> Configuring the command register, if the transfer of data needs
>> dual or quad lines.
>>
>> This patch has been done on top of the following patch[1], which is just the
>> basic idea of adding dual/quad support in spi framework.
>> $subject patch will undergo changes as the parent patch goes[1]
>>
>> [1]: http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047
> Just as with commit IDs you should include a plain text description of
> anything you link to so that people reading your e-mail can tell what
> you're talking about without going on line.
Ok, will keep that in mind for future.

Just to give you a brief description here,
Requirement is to have a dual/quad support in spi frameowrk, so that
drivers can use multiple lines for data transfers.

What patch[1] tries to does, is
[1]:  http://comments.gmane.org/gmane.linux.kernel.spi.devel/14047

is to add to each transfer the bitwidth it supports, so that that 
bitwidth information
can be parsed in controller driver and can be used for respective 
read/writes.

A typical usecase on my side is,
I have a spansion flash connected to qspi. Flash device supports quad 
read with
a certain read opcode(QUAD_READ). So, Whenever the opcode send is QUAD_READ,
we will append that information as a bitwidth to the spi transfer. This 
information will
be parsed by the controller driver and will be used to configure the cmd 
reg to do
the particular type of reads.

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
