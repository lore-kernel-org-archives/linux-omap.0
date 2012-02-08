From: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Minimum timing resolution in Ubuntu/Linaro on the PandaBoard ES
Date: Wed, 08 Feb 2012 08:58:42 -0800
Message-ID: <1328720322.8119.7.camel@js-netbook>
References: <4F31A91B.8080106@umich.edu> <4F32063F.1020607@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F32063F.1020607-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Dmitry Antipov <dmitry.antipov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Andrew Richardson <chardson-63aXycvo3TyHXe+LvDLADg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 2012-02-07 at 21:21 -0800, Dmitry Antipov wrote:
> BTW, I have no ideas why clock_getres(CLOCK_REALTIME,...) returns {0, 1}
> regardless of underlying clock source. I expect {0, 30517} for 32K timer
> and {0, 26} for MPU timer.

Yea. I had proposed to export the underlying clocksource's resolution
via clock_getres, but it was argued against. The concern is that
applications might not expect clock_getres to change while the
application is running.  Between any clock_getres() call and a time
read, the clocksources could change.

But if someone has a different reading of the posix spec, it might be
good to revisit this.

thanks
-john
