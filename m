From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: omap GPIO programming
Date: Thu, 25 Oct 2007 19:24:49 -0500
Message-ID: <472133D1.30504@gmail.com>
References: <c656a4d20710240205h37ed0e13m2484fba021ecd889@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c656a4d20710240205h37ed0e13m2484fba021ecd889@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: arun c <arun.edarath@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

arun c stated on 10/24/2007 4:05 AM:
> Whether i have to set pin muxing or use any other kernel api to use
> the GPIOS 142 and 87?? please help me.
in general yes. I usually refer to the corresponding OMAP Data Manual to
get which ballout  I am interested in, and then see the TRM for the
corresponding register to set. omap2430 pin muxing is very straight
forward and should be easy to do.

Regards,
Nishanth Menon
