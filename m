From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Use I2C bus registration helper
Date: Thu, 08 Nov 2007 06:42:51 -0600
Message-ID: <4733044B.9070307@gmail.com>
References: <1194432873-5209-1-git-send-email-jarkko.nikula@nokia.com>
	<1194432873-5209-3-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1194432873-5209-3-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Jarkko,
Jarkko Nikula stated on 11/7/2007 4:54 AM:
> This patch starts using introduced I2C bus registration helper by cleaning
> up registration currently done in various places and by doing necessary
> board file modifications.


How do I handle Bus segments on (currently) a hypothetical situation
where i have HS and FS devices on the same i2c bus? There was a long
discussion
(http://lists.lm-sensors.org/pipermail/i2c/2007-April/001038.html )

I am not sure we want to loose that flexibility..

Regards,
Nishanth Menon
