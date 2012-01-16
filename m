From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v6 0/6] PM QoS: implement the OMAP low level
 constraints management code
Date: Mon, 16 Jan 2012 21:22:09 +0100
Message-ID: <CAORVsuWFBhJ=rOrQG2fawNkR6u3=DTr2HpVGCs+Mg+QE7dy1VA@mail.gmail.com>
References: <1323874304-5001-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1112191337420.12660@utopia.booyaka.com>
	<CAORVsuVNvvPu6it7r_uxc0f6H-9kpo6SChTTGkdqpLmzMDNxvQ@mail.gmail.com>
	<alpine.DEB.2.00.1201161301450.16675@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1201161301450.16675@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Paul,

On Mon, Jan 16, 2012 at 9:04 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Mon, 16 Jan 2012, Jean Pihet wrote:
>
>> Speaking of the locking, currently a spinlock is used and it could be
>> replaced by a more efficient mutex. This is ok at the condition that
>> this code is not called from interrupt context?
>>
>> Kevin,
>> Do you know if the per-device constraint code can be called from
>> interrupt context?
>
> It can't be. =A0It uses a mutex itself. =A0So a mutex is what we want. =
=A0Take a
> look at drivers/base/power/qos.c:dev_pm_qos_update_request() (included
> below)
Ok thanks for checking, I should have done it before asking ;-|

Jean

>
>
> - Paul
>
>
> /**
> =A0* dev_pm_qos_update_request - modifies an existing qos request
> =A0* @req : handle to list element holding a dev_pm_qos request to use
> =A0* @new_value: defines the qos request
> =A0*
> =A0* Updates an existing dev PM qos request along with updating the
> =A0* target value.
> =A0*
> =A0* Attempts are made to make this code callable on hot code paths.
> =A0*
> =A0* Returns 1 if the aggregated constraint value has changed,
> =A0* 0 if the aggregated constraint value has not changed,
> =A0* -EINVAL in case of wrong parameters, -ENODEV if the device has been
> =A0* removed from the system
> =A0*/
> int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s32 new_value)
> {
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> =A0 =A0 =A0 =A0if (!req) /*guard against callers passing in null */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0if (WARN(!dev_pm_qos_request_active(req),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s() called for unknown object\n", __fun=
c__))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> =A0 =A0 =A0 =A0mutex_lock(&dev_pm_qos_mtx);
>
> =A0 =A0 =A0 =A0if (req->dev->power.constraints) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (new_value !=3D req->node.prio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D apply_constraint(r=
eq, PM_QOS_UPDATE_REQ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 new_value);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Return if the device has been removed */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> =A0 =A0 =A0 =A0return ret;
> }
>
