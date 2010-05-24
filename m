From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 24 May 2010 07:32:24 +0300
Message-ID: <20100524043224.GA31700@nokia.com>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	<201005240246.55043.rjw@sisk.pl>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005240246.55043.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "ext Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, May 24, 2010 at 02:46:54AM +0200, ext Rafael J. Wysocki wrote:
>On Saturday 22 May 2010, Arve Hj=F8nnev=E5g wrote:
>> This patch series adds a suspend-block api that provides the same
>> functionality as the android wakelock api. This version adds a
>> delay before suspending again if no suspend blockers were used
>> during the last suspend attempt.
>
>Patches [1-6/8] applied to suspend-2.6/linux-next

funny thing is that even without sorting out the concerns plenty of =

developers had on the other thread, this series is still taken. What's =

the point in dicussing/reviewing the patches then ?

-- =

balbi

DefectiveByDesign.org
